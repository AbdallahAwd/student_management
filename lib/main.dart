import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_system/config/resources/app_styles.dart';
import 'package:student_system/config/resources/cache_keys.dart';
import 'package:student_system/features/home/presentation/pages/home.dart';
import 'package:student_system/features/login/presentation/cubit/login_cubit.dart';

import 'bloc_observer.dart';
import 'config/Cache/cache_helper.dart';
import 'features/login/presentation/pages/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Cache.init();
  final token = Cache.getData(key: CacheKeys.token);

  Bloc.observer = MyBlocObserver();
  runApp(MyApp(
    token: token,
  ));
}

class MyApp extends StatelessWidget {
  final String? token;
  final String? role;
  const MyApp({super.key, this.token, this.role});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit()
            ..loadJson()
            ..loadJson(false),
        )
      ],
      child: MaterialApp(
        title: 'Student',
        debugShowCheckedModeBanner: false,
        theme: AppStyles.lightThemeData,
        home: token == null ? const Login() : const Home(),
      ),
    );
  }
}
