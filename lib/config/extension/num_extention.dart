import 'package:flutter/material.dart';

extension FontSize on num {
  SizedBox get sbw => SizedBox(
        width: toDouble(),
      );
  SizedBox get sbh => SizedBox(
        height: toDouble(),
      );
  String get stringifyGrade {
    final grades = ['1st', '2sec', '3rd', '4th'];
    return grades[toInt() - 1];
  }
}
