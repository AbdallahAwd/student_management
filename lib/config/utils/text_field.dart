import 'package:flutter/material.dart';

class DefTextField extends StatelessWidget {
  final String hintText;
  final bool isSecure;
  final bool? isEnabled;
  final TextEditingController controller;
  final Widget? suffixicon;
  final String? Function(String?)? validate;
  final void Function(String)? onChange;
  final Widget? prefexicon;
  final void Function()? onTap;
  final TextInputType? textInputType;
  const DefTextField(
      {Key? key,
      this.isEnabled,
      required this.hintText,
      this.onChange,
      this.onTap,
      this.isSecure = false,
      this.suffixicon,
      this.prefexicon,
      required this.controller,
      required this.validate,
      this.textInputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isSecure,
      controller: controller,
      validator: validate,
      enabled: isEnabled,
      keyboardType: textInputType,
      onTap: onTap,
      onChanged: onChange,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 13),
          prefixIcon: prefexicon,
          suffixIcon: suffixicon,
          isCollapsed: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.white, width: 1),
          )),
    );
  }
}
