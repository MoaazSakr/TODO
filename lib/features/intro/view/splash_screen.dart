import 'package:flutter/material.dart';
import 'package:todo/core/function/navigation.dart';
import 'package:todo/core/services/local_helper.dart';
import 'package:todo/core/utlis/app_assets.dart';
import 'package:todo/features/home/view/home_screen.dart';
import 'package:todo/features/intro/view/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
void initState() {
  super.initState();
  Future.delayed(const Duration(seconds: 3), () {
    pushReplacement(
        context,
        AppLocalStorage.getData('name').isNotEmpty
            ? const HomeScreen()
            : const WelcomeScreen(),
      );
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          AppAssets.splash,
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}