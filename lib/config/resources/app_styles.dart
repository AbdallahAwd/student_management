import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';

class AppStyles {
  static ThemeData lightThemeData = ThemeData(
    primaryColor: Colors.blue,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
    textTheme: Typography.englishLike2018.apply(
        fontSizeFactor: 1, bodyColor: Colors.black, fontFamily: "OpenSans"),
    appBarTheme: AppBarTheme(
      color: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black),
      actionsIconTheme: const IconThemeData(color: Colors.black),
      elevation: 0,
      centerTitle: true,
      toolbarTextStyle: const TextTheme(
        titleLarge: TextStyle(
            fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
      ).bodyMedium,
      titleTextStyle: const TextTheme(
        titleLarge: TextStyle(
            fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
      ).titleLarge,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      //   filled: true,
      //   fillColor: Colors.grey[250],
      //   border: OutlineInputBorder(
      //     // borderSide: BorderSide.none,
      //     borderRadius: BorderRadius.circular(10.0),
      //   ),
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.pColorSwatch,
    primarySwatch: AppColors.pColorSwatch,
    scaffoldBackgroundColor: Colors.black,
    brightness: Brightness.dark,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          fontSize: 28.0, fontWeight: FontWeight.bold, fontFamily: "Cairo"),
      displayMedium: TextStyle(
          fontSize: 24.0, fontWeight: FontWeight.bold, fontFamily: "Cairo"),
      displaySmall: TextStyle(
          fontSize: 20.0, fontWeight: FontWeight.bold, fontFamily: "Cairo"),
      headlineMedium: TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.bold, fontFamily: "Cairo"),
      headlineSmall: TextStyle(
          fontSize: 16.0, fontWeight: FontWeight.bold, fontFamily: "Cairo"),
      titleLarge: TextStyle(
          fontSize: 14.0, fontWeight: FontWeight.bold, fontFamily: "Cairo"),
      bodyLarge: TextStyle(
        fontSize: 16.0,
        color: Colors.white,
        fontFamily: "Cairo",
      ),
      bodyMedium:
          TextStyle(fontSize: 14.0, color: Colors.white70, fontFamily: "Cairo"),
      titleMedium:
          TextStyle(fontSize: 14.0, color: Colors.white, fontFamily: "Cairo"),
      titleSmall:
          TextStyle(fontSize: 12.0, color: Colors.white70, fontFamily: "Cairo"),
      labelLarge: TextStyle(
          fontSize: 16.0, fontWeight: FontWeight.bold, fontFamily: "Cairo"),
      bodySmall:
          TextStyle(fontSize: 12.0, color: Colors.white70, fontFamily: "Cairo"),
      labelSmall: TextStyle(
          fontSize: 10.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
          color: Colors.white,
          fontFamily: "Cairo"),
    ),
    appBarTheme: AppBarTheme(
      color: Colors.black38,
      iconTheme: const IconThemeData(color: Colors.white),
      actionsIconTheme: const IconThemeData(color: Colors.white),
      elevation: 0,
      centerTitle: true,
      toolbarTextStyle: const TextTheme(
        titleLarge: TextStyle(
            fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
      ).bodyMedium,
      titleTextStyle: const TextTheme(
        titleLarge: TextStyle(
            fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
      ).titleLarge,
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.pColorSwatch,
      disabledColor: Colors.grey,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: Colors.white70,
      thickness: 1,
      space: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[800],
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10.0),
      ),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
    ),
    cardTheme: CardTheme(
      color: Colors.grey[900],
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );
}
