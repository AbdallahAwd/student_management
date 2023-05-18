import 'package:flutter/material.dart';

extension FontSize on num {
  SizedBox get sbw => SizedBox(
        width: toDouble(),
      );
  SizedBox get sbh => SizedBox(
        height: toDouble(),
      );
}
