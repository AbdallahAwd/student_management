import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:student_system/config/extension/context_ex.dart';
import 'package:student_system/config/extension/num_extention.dart';
import 'package:student_system/config/extension/string_extention.dart';
import 'package:student_system/config/extension/widget_extension.dart';
import 'package:student_system/config/resources/constant.dart';
import 'package:student_system/features/home/presentation/pages/home.dart';
import 'package:student_system/features/login/presentation/pages/register.dart';
import '../../../../config/utils/components.dart';
import '../../../../config/utils/def_button.dart';
import '../../../../config/utils/text_field.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';
import '../widgets/arrow.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isPassword = true;
  IconData eyeIcon = Icons.visibility;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is RegisterError) {
          C.snack(
            context,
            state.error,
            onTap: () {
              emailController.clear();
              passwordController.clear();
            },
          );
        }
        if (state is RegisterSuccess) {
          C.navToRemove(context, const Home());
        }
      },
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: const ArrowBack(),
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  const Text(
                    "Welcome back! Glad to see you, Again!",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  25.sbh,
                  DefTextField(
                    hintText: "Enter your email or phone",
                    controller: emailController,
                    validate: (String? value) {
                      if (value!.contains(cubit.phoneRegex)) {
                        if (!cubit.phoneRegex.hasMatch(value.trim())) {
                          return "Enter a valid Phone";
                        }
                      } else {
                        if (!cubit.emailRegex.hasMatch(value.trim())) {
                          return "Enter a valid Email";
                        }
                      }

                      return null;
                    },
                    prefexicon: const Icon(Icons.email_outlined),
                  ),
                  15.sbh,
                  DefTextField(
                    validate: (value) {
                      if (value!.length < 8) {
                        return "Password must be more than 8 characters";
                      }
                      return null;
                    },
                    isSecure: isPassword,
                    controller: passwordController,
                    prefexicon: const Icon(Icons.lock_open_outlined),
                    hintText: "Enter your password",
                    suffixicon: Icon(eyeIcon).onTap(() {
                      setState(() {
                        isPassword = !isPassword;
                        eyeIcon = isPassword
                            ? Icons.visibility
                            : Icons.visibility_off_outlined;
                      });
                    }),
                  ),
                  8.sbh,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      "Forget Password?".txt(fontSize: 12),
                    ],
                  ),
                  const Spacer(),
                  DefButton(
                    text: "Login",
                    color: Colors.black,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        cubit.login(
                            emailOrPhone: emailController.text,
                            password: passwordController.text);
                      }
                    },
                    isLoading: state is RegisterLoading,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Container(
                        width: context.sw(0.32),
                        height: 1,
                        color: Colors.grey,
                      ),
                      7.5.sbw,
                      'Or Login with'.txt(color: Colors.grey),
                      7.5.sbw,
                      Container(
                        width: context.sw(0.32),
                        height: 1,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  const Spacer(),
                  SizedBox(
                    height: context.sh(0.068),
                    width: Platform.isIOS ? context.width : context.sw(0.56),
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return _socialButton(Platform.isIOS
                              ? ['facebook', 'google_ic', 'apple'][index]
                              : ['facebook', 'google_ic'][index]);
                        },
                        separatorBuilder: (context, index) => 15.sbw,
                        itemCount: Platform.isIOS ? 3 : 2),
                  ),
                  const Spacer(),
                  const Spacer(),
                  const Spacer(),
                  const Spacer(),
                  const Spacer(),
                  if (Constant.isAdmin)
                    Row(
                      children: [
                        const Text("Don’t have an account?"),
                        TextButton(
                            onPressed: () {
                              C.navToDown(context, const Register());
                            },
                            child: 'Register Now'.txt(color: Colors.green))
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _socialButton(String asseticon) {
    return Container(
      width: 100,
      height: 60,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey, width: 1)),
      child: SvgPicture.asset(asseticon.toSvg),
    ).onTap(() {
      if (asseticon == 'google_ic') {
        // LoginCubit.get(context).googleLogin();
      }
    });
  }
}
