import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:todo/core/function/navigation.dart';
import 'package:todo/core/utlis/app_assets.dart';
import 'package:todo/core/utlis/app_color.dart';
import 'package:todo/features/auth/view/login_screen.dart';
import 'package:todo/features/widgets/custom_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SvgPicture.asset(AppAssets.welcome),
                const Text(
                  'Welcome To Do It !',
                  style: TextStyle(
                    color: AppColor.textColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Gap(16),
                const Text(
                  "Ready to conquer your tasks? Let's Do It together",
                  style: TextStyle(
                    color: AppColor.greyColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                Spacer(),
                CustomButton(text: 'Let’s Start',onPressed: () => pushReplacement(context, LoginScreen()),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
