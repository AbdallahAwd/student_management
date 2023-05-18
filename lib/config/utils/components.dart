import 'dart:math';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class C {
  static pop(context, [bool? result]) => Navigator.pop(context, result);
  static navTo(context, Widget screen) {
    Navigator.push(context,
        PageTransition(type: PageTransitionType.rightToLeft, child: screen));
  }

  static navToRemove(context, Widget screen) {
    Navigator.pushAndRemoveUntil(
      context,
      PageTransition(type: PageTransitionType.rightToLeft, child: screen),
      (route) => false,
    );
  }

  static navToReplace(context, Widget screen) {
    Navigator.pushReplacement(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeftWithFade, child: screen));
  }

  static navToFade(context, Widget screen) {
    Navigator.push(
        context, PageTransition(type: PageTransitionType.fade, child: screen));
  }

  static navToDown(context, Widget screen) {
    Navigator.push(context,
        PageTransition(type: PageTransitionType.bottomToTop, child: screen));
  }

  static Color getRandomColor() {
    Random random = Random();
    int r = random.nextInt(256);
    int g = random.nextInt(256);
    int b = random.nextInt(256);
    return Color.fromARGB(255, r, g, b);
  }

  static snack(context, String content, {void Function()? onTap}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Retry',
          textColor: Colors.white,
          onPressed: onTap ?? () {},
        ),
      ),
    );
  }
}
