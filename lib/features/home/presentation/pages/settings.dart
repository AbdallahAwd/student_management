import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:student_system/config/resources/cache_keys.dart';
import 'package:student_system/config/utils/components.dart';
import 'package:student_system/features/home/models/user_model.dart';
import 'package:student_system/features/home/presentation/pages/update.dart';
import 'package:student_system/features/login/presentation/cubit/login_cubit.dart';

import '../../../../config/Cache/cache_helper.dart';

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
      body: SafeArea(
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
                title: const Text('Password'),
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.all_inclusive_outlined),
                title: const Text('All Info'),
              ),
            ]),
            SettingsSection(title: const Text('Others'), tiles: [
              SettingsTile.navigation(
                leading: const Icon(Icons.logout),
                onPressed: (context) {
                  final token = Cache.getData(key: CacheKeys.token);
                  LoginCubit.get(context).logout(context, token);
                },
                title: const Text('Logout'),
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.delete_forever_outlined),
                title: const Text('Delete Account'),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
