import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo/core/utlis/app_assets.dart';
import 'package:todo/features/auth/data/user_model.dart';

class Header extends StatelessWidget {
  const Header({super.key, this.userModel});
  
  final UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(radius: 30, backgroundImage: AssetImage(AppAssets.logo)),
        const Gap(10),
        Text(
          'Hello, ${userModel?.username ?? 'User'}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}