import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo/core/function/navigation.dart';
import 'package:todo/features/widgets/header.dart';
import 'package:todo/features/settings/view/update_profile_screen.dart';
import 'package:todo/features/settings/view/change_password_screen.dart';
import 'package:todo/features/settings/view/settings_screen.dart';
import 'package:todo/features/widgets/settings_container.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Header(),
            Gap(10),
            SettingsContainer(
              icon: Icons.person_outline_outlined,
              text: 'profile',
              onTap: () {
                push(context, UpdateProfileScreen());
              },
            ),
            Gap(10),
            SettingsContainer(
              icon: Icons.lock_outline_rounded,
              text: 'Change Password',
              onTap: () {
                push(context, ChangePasswordScreen());
              },
            ),
            Gap(10),
            SettingsContainer(
              icon: Icons.settings_outlined,
              text: 'Settings',
              onTap: () {
                push(context, SettingsScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
