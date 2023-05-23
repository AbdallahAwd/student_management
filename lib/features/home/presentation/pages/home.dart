import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:student_system/config/Cache/cache_helper.dart';
import 'package:student_system/config/extension/string_extention.dart';
import 'package:student_system/config/extension/widget_extension.dart';
import 'package:student_system/config/resources/cache_keys.dart';
import 'package:student_system/features/home/presentation/cubit/home_cubit.dart';
import 'package:student_system/features/home/presentation/cubit/home_state.dart';
import 'package:student_system/features/home/presentation/pages/profile.dart';
import 'package:student_system/features/home/presentation/pages/settings.dart';
import 'package:student_system/features/home/presentation/widgets/student_builder.dart';

import '../../../../config/utils/components.dart';

class Home extends StatefulWidget {
  final String? token;
  const Home({Key? key, required this.token}) : super(key: key);

  @override
  State createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final id = CacheHelper.getData(key: CacheKeys.id);
  final token = CacheHelper.getData(key: CacheKeys.token);
  @override
  void initState() {
    super.initState();
    HomeCubit.get(context).getUserInfo(id.toString(), widget.token!);
  }

  //
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        // if (cubit.pdfModel == null) {
        //   cubit.getSubjectPdf(Cache.getData(key: CacheKeys.grade) ?? 3);
        // }
        if (cubit.pdfModel != null) {
          return Scaffold(
            backgroundColor: const Color(0xffeeeeee),
            appBar: AppBar(
              backgroundColor: const Color(0xffeeeeee),
              leading: SvgPicture.asset(
                'setting'.toSvg,
              ).onTap(() {
                C.navToDown(
                    context,
                    Settings(
                      user: cubit.userModel!.user!,
                    ));
              }),
              actions: [
                Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: C.getRandomColor(), shape: BoxShape.circle),
                    child: Center(
                      child: Text(
                        cubit.userModel!.user!.name!.firstLetters,
                        style: const TextStyle(fontSize: 20),
                      ),
                    )).paddingSymmetric(10, 0).onTap(() {
                  C.navToDown(
                      context,
                      Profile(
                        user: cubit.userModel!.user!,
                      ));
                }),
              ],
            ),
            body: StudentOrDoctorBuilder(
                user: cubit.userModel!.user!,
                subjects: cubit.pdfModel!.result!),
          );
        } else {
          return Scaffold(
            body: BlocListener<HomeCubit, HomeState>(
              listener: (context, state) {
                if (state is GetUserError) {
                  Future.delayed(const Duration(seconds: 5), () {
                    HomeCubit.get(context)
                        .getUserInfo(id.toString(), widget.token!);
                  });
                }
              },
              child: const Center(child: CircularProgressIndicator()),
            ),
          );
        }
      },
    );
  }
}
