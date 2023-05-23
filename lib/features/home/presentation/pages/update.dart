import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:student_system/config/extension/num_extention.dart';
import 'package:student_system/config/extension/string_extention.dart';
import 'package:student_system/config/utils/def_button.dart';
import 'package:student_system/config/utils/text_field.dart';
import 'package:student_system/features/login/presentation/cubit/login_cubit.dart';

class Update extends StatefulWidget {
  final String value;
  final int index;
  const Update({Key? key, required this.value, required this.index})
      : super(key: key);

  @override
  State createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  final activeController = TextEditingController();
  final form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: form,
          child: Column(
            children: <Widget>[
              'Note : Here you could update your data very easliy'
                  .txt(color: Colors.grey),
              20.sbh,
              DefTextField(
                hintText: 'Current',
                controller: TextEditingController(text: widget.value),
                isEnabled: false,
                prefexicon: const Icon(Icons.ramen_dining),
                validate: (p0) {
                  return null;
                },
              ),
              20.sbh,
              DefTextField(
                hintText: 'New',
                controller: activeController,
                prefexicon: const Icon(Icons.ac_unit_rounded),
                validate: (String? value) {
                  if (widget.index == 1) {
                    if (!LoginCubit.get(context)
                        .emailRegex
                        .hasMatch(value!.trim())) {
                      return 'Enter a valid email';
                    }
                  }

                  return null;
                },
              ),
              30.sbh,
              DefButton(
                text: 'Update',
                color: Colors.black,
                onPressed: () {
                  if (form.currentState!.validate()) {
                    log('message');
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
