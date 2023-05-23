import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_system/config/extension/num_extention.dart';
import 'package:student_system/config/extension/string_extention.dart';
import 'package:student_system/config/utils/def_button.dart';
import 'package:student_system/config/utils/text_field.dart';
import 'package:student_system/features/login/presentation/cubit/login_cubit.dart';

import '../../../../config/utils/components.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';

class Update extends StatefulWidget {
  final String value;
  final int index;
  final bool isPassword;
  const Update(
      {Key? key,
      required this.value,
      required this.index,
      this.isPassword = false})
      : super(key: key);

  @override
  State createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  final activeController = TextEditingController();
  final oldPassController = TextEditingController();
  final form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update'),
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is UpdateUserInfoSuccess) {
            C.toast(state.message);
            C.pop(context);
          }
          if (state is UpdateUserInfoError) {
            C.snack(
              context,
              state.message,
              onTap: () {
                activeController.clear();
                oldPassController.clear();
              },
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: form,
              child: Column(
                children: <Widget>[
                  'Note : Here you could update your data very easliy'
                      .txt(color: Colors.grey),
                  20.sbh,
                  DefTextField(
                    hintText: 'Current Password',
                    controller: widget.index == 2
                        ? oldPassController
                        : TextEditingController(text: widget.value),
                    isEnabled: widget.isPassword,
                    prefexicon: rightIcon(),
                    validate: (p0) {
                      if (p0!.isEmpty) {
                        return 'Enter the current Password';
                      }
                      return null;
                    },
                  ),
                  20.sbh,
                  DefTextField(
                    hintText: widget.index == 2 ? 'New Password' : 'New',
                    controller: activeController,
                    prefexicon: rightIcon(),
                    validate: (String? value) {
                      if (widget.index == 1) {
                        if (!LoginCubit.get(context)
                            .emailRegex
                            .hasMatch(value!.trim())) {
                          return 'Enter a valid email';
                        }
                      } else if (widget.index == 0) {
                        if (value!.length <= 4) {
                          return 'Enter a valid Name';
                        }
                      } else {
                        if (value!.length <= 8) {
                          return 'Enter a valid Password';
                        }
                      }

                      return null;
                    },
                  ),
                  30.sbh,
                  DefButton(
                    text: 'Update',
                    isLoading: state is UpdateUserInfoLoading,
                    color: Colors.black,
                    onPressed: () {
                      if (form.currentState!.validate()) {
                        if (widget.index != 2) {
                          HomeCubit.get(context).updateUserInfo(
                              field: widget.index == 0 ? 'name' : 'email',
                              value: activeController.text.trim());
                        }
                        HomeCubit.get(context).updateUserPassword(
                            currentPassword: oldPassController.text.trim(),
                            newPassword: activeController.text.trim());
                      }
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget rightIcon() {
    if (widget.index == 0) {
      return const Icon(Icons.person);
    }
    if (widget.index == 1) {
      return const Icon(Icons.email);
    }
    return const Icon(Icons.lock);
  }
}
