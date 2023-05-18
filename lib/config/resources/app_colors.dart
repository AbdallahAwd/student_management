import 'package:flutter/material.dart';

class AppColors {
  static const List<Color> mainGradiantColors = [
    Color(0xffDA4994),
    Color(0xff983C8E),
    Color(0xff5D2F70),
    Color(0xff3E2567),
    Color(0xff272264),
  ];

  static Color mainColor = const Color(0xff983C8E);
  static const Color secColor = Color(0xffDA4994);

  static const MaterialColor pColorSwatch = MaterialColor(
    0xff3E2567,
    <int, Color>{
      50: Color(0xffDA4994), //10%
      100: Color(0xffDA4994), //20%
      200: Color(0xffDA4994), //30%
      300: Color(0xff983C8E), //40%
      400: Color(0xff983C8E), //50%
      500: Color(0xff5D2F70), //60%
      600: Color(0xff5D2F70), //70%
      700: Color(0xff3E2567), //80%
      800: Color(0xff3E2567), //90%
      900: Color(0xff272264), //100%
    },
  );
}
