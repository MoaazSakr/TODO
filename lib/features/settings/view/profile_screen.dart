import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo/core/network/api_helper.dart';
import 'package:todo/core/utlis/app_color.dart';
import 'package:todo/core/widgets/custom_button.dart';
import 'package:todo/core/widgets/header.dart';
import 'package:todo/features/auth/view/login_screen.dart';
import 'package:todo/features/settings/view/update_profile_screen.dart';
import 'package:todo/features/settings/view/change_password_screen.dart';
import 'package:todo/features/settings/view/settings_screen.dart';
import 'package:todo/core/widgets/settings_container.dart';
import 'package:todo/features/auth/data/user_model.dart';

class ProfileScreen extends StatefulWidget {
  final UserModel? userModel;
  const ProfileScreen({super.key, this.userModel});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel? currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = widget.userModel;
  }

  void fetchUser() async {
    var result = await APIHelper.getUserData();
    result.fold(
      (error) {}, 
      (user) {
        if (mounted) {
          setState(() {
            currentUser = user;
          });
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Header(userModel: currentUser),
              const Gap(10),
              SettingsContainer(
                icon: Icons.person_outline_outlined,
                text: 'profile',
                onTap: () async {
                  await Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateProfileScreen()));
                  fetchUser(); // تحديث الاسم لو اتغير في شاشة التعديل
                },
              ),
              const Gap(10),
              SettingsContainer(
                icon: Icons.lock_outline_rounded,
                text: 'Change Password',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangePasswordScreen()));
                },
              ),
              const Gap(10),
              SettingsContainer(
                icon: Icons.settings_outlined,
                text: 'Settings',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
                },
              ),
              const Spacer(),
              CustomButton(
                text: 'Logout',
                onPressed: () async {
                  await APIHelper.logout();
                  if (context.mounted) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                      (route) => false,
                    );
                  }
                },
              ),
              const Gap(10),
              CustomButton(
                text: 'Delete Account',
                onPressed: () async {
                  await APIHelper.deleteUser();
                  if (context.mounted) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                      (route) => false,
                    );
                  }
                },
                color: AppColor.errorColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}