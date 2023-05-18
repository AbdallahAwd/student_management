import 'package:flutter/material.dart';

extension GoOnWidget on Widget {
  Padding paddingAll(double? padding) => Padding(
        padding: EdgeInsets.all(padding ?? 8),
        child: this,
      );
  Padding paddingSymmetric(double? horizontal, double? vertical) => Padding(
        padding: EdgeInsets.symmetric(
            horizontal: horizontal ?? 8, vertical: vertical ?? 8),
        child: this,
      );

  InkWell onTap(VoidCallback onTap, {Color splashColor = Colors.grey}) =>
      InkWell(
        onTap: onTap,
        splashColor: splashColor,
        borderRadius: BorderRadius.circular(12),
        child: this,
      );
}
