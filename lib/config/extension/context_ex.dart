import 'package:flutter/material.dart';

extension Measures on BuildContext {
  double get hight => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
  double sw(double num) => width * num;
  double sh(double num) => hight * num;
}
