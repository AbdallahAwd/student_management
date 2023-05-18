import 'package:flutter/material.dart';
import 'package:student_system/config/extension/context_ex.dart';

import '../resources/app_colors.dart';

class DefButton extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final VoidCallback onPressed;
  final bool isLoading;

  final double? width;
  final Color? color;
  final double? borderRadius;
  final IconData? icon;
  final double? hight;
  const DefButton(
      {Key? key,
      required this.text,
      this.textStyle,
      required this.color,
      required this.onPressed,
      this.isLoading = false,
      this.width,
      this.hight,
      this.icon,
      this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double rwidth = width == null ? context.sw(0.88) : width!;
    return Container(
        width: rwidth,
        height: hight,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          gradient: color == null
              ? const LinearGradient(colors: AppColors.mainGradiantColors)
              : null,
          borderRadius: BorderRadius.circular(borderRadius ?? 8),
          color: color ?? Colors.black,
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: MaterialButton(
            onPressed: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) Icon(icon),
                if (icon != null)
                  const SizedBox(
                    width: 10,
                  ),
                Text(
                  text,
                  style: textStyle ??
                      const TextStyle(color: Colors.white, fontSize: 18),
                ),
                if (isLoading)
                  const SizedBox(
                    width: 10,
                  ),
                if (isLoading)
                  const SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator(
                        strokeWidth: 0.8,
                        color: Colors.white,
                      )),
              ],
            )));
  }
}
