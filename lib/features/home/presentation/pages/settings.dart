import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:student_system/config/extension/widget_extension.dart';
import 'package:student_system/config/resources/cache_keys.dart';
import 'package:student_system/config/utils/components.dart';
import 'package:student_system/features/home/models/user_model.dart';
import 'package:student_system/features/home/presentation/cubit/home_cubit.dart';
import 'package:student_system/features/home/presentation/pages/profile.dart';
import 'package:student_system/features/home/presentation/pages/update.dart';
import 'package:student_system/features/login/presentation/cubit/login_cubit.dart';
import 'package:student_system/features/login/presentation/pages/login.dart';

import '../../../../config/Cache/cache_helper.dart';
import '../cubit/home_state.dart';

class Settings extends StatefulWidget {
  final User user;
  const Settings({Key? key, required this.user}) : super(key: key);

  @override
  State createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is DeleteUserSuccess) {
            CacheHelper.removeData(CacheKeys.id);
            CacheHelper.removeData(CacheKeys.token);
            CacheHelper.removeData(CacheKeys.grade);
            C.toast(state.message);
            C.navToRemove(context, const Login());
          }
          if (state is DeleteUserError) {
            C.snack(context, state.message);
          }
        },
        child: SafeArea(
          child: SettingsList(
            sections: [
              SettingsSection(
                title: const Text('Common'),
                tiles: <SettingsTile>[
                  SettingsTile.navigation(
                    leading: const Icon(Icons.language),
                    title: const Text('Language'),
                    value: const Text('English'),
                    onPressed: (context) {
                      C.toast('Soon');
                    },
                  ),
                ],
              ),
              SettingsSection(title: const Text('User'), tiles: [
                SettingsTile.navigation(
                  description: Text(widget.user.name!),
                  onPressed: (context) {
                    C.navToDown(
                        context,
                        Update(
                          index: 0,
                          value: widget.user.name!,
                        ));
                  },
                  leading: const Icon(Icons.person),
                  title: const Text('Name'),
                ),
                SettingsTile.navigation(
                  description: Text(widget.user.email!),
                  onPressed: (context) {
                    C.navToDown(
                        context,
                        Update(
                          index: 1,
                          value: widget.user.email!,
                        ));
                  },
                  leading: const Icon(Icons.email_outlined),
                  title: const Text('Email'),
                ),
                SettingsTile.navigation(
                  description: const Text('*************'),
                  leading: const Icon(Icons.lock_clock),
                  onPressed: (context) {
                    C.navToDown(
                        context,
                        const Update(
                          index: 2,
                          value: '',
                          isPassword: true,
                        ));
                  },
                  title: const Text('Password'),
                ),
                SettingsTile.navigation(
                  leading: const Icon(Icons.all_inclusive_outlined),
                  title: const Text('All Info'),
                  onPressed: (context) {
                    C.navToDown(
                        context,
                        Profile(
                          user: widget.user,
                        ));
                  },
                ),
              ]),
              SettingsSection(title: const Text('Others'), tiles: [
                SettingsTile.navigation(
                  leading: const Icon(Icons.logout),
                  onPressed: (context) {
                    final token = CacheHelper.getData(key: CacheKeys.token);
                    LoginCubit.get(context).logout(context, token);
                  },
                  title: const Text('Logout'),
                ),
                SettingsTile.navigation(
                  leading: const Icon(Icons.delete_forever_outlined),
                  title: const Text('Delete Account'),
                  onPressed: (context) {
                    showAlertDialog(context);
                  },
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }

  void showAlertDialog(context) {
    AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.warning,
      body: Center(
        child: const Text(
          "Deleting your account is a permanent action and cannot be undone. By deleting your account, you will lose access to all your data, including your saved settings, preferences, and any associated content. This includes any purchases, messages, or interactions you've had on the platform. If you're sure about deleting your account, please proceed with caution. Make sure to back up any important information or files before initiating the deletion process. If you have any concerns or issues, we recommend reaching out to our support team for assistance.",
          style: TextStyle(fontStyle: FontStyle.italic),
        ).paddingSymmetric(20, 0),
      ),
      title: 'This is Ignored',
      desc: 'This is also Ignored',
      btnOkOnPress: () {
        final id = CacheHelper.getData(key: CacheKeys.id);
        HomeCubit.get(context).deleteUser(id);
      },
      btnOkColor: Colors.yellow,
    ).show();
  }
}
