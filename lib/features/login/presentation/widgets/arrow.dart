import 'package:flutter/material.dart';
import 'package:student_system/config/extension/widget_extension.dart';

import '../../../../config/utils/components.dart';

class ArrowBack extends StatelessWidget {
  const ArrowBack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(12)),
        child: const Icon(Icons.arrow_back_ios_new).onTap(() {
          C.pop(context);
        }),
      ),
    );
  }
}
