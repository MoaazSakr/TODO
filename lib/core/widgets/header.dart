import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo/core/utlis/app_assets.dart';
import 'package:todo/features/auth/data/login_response_model.dart';

class Header extends StatefulWidget {
  Header({super.key});
  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(radius: 30, backgroundImage: AssetImage(AppAssets.logo)),
        Gap(10),
        Text(
          "Hello, \n${LoginResponseModel().userModel?.username ?? 'User'}",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
