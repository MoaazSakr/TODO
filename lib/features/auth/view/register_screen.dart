import 'dart:core';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo/core/function/navigation.dart';
import 'package:todo/core/services/local_helper.dart';
import 'package:todo/core/utlis/app_assets.dart';
import 'package:todo/features/home/view/home_screen.dart';
import 'package:todo/features/auth/view/login_screen.dart';
import 'package:todo/features/widgets/custom_button.dart';
import 'package:todo/features/widgets/custom_form_widget.dart';
import 'package:todo/features/widgets/password_form_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _passwordController = TextEditingController();
  bool isPasswordVisible = true;
  final nameController = TextEditingController();
@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.asset(AppAssets.logo, width: double.infinity, height: 298),
              Gap(10),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomFormWidget(
                      text: 'Name',
                      keyboardType: TextInputType.name,
                      icon: Icons.person,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    Gap(10),
                    PasswordFormWidget(
                      isShow: isPasswordVisible,
                      isConfirmPassword: false,
                    ),
                    Gap(10),
                    PasswordFormWidget(
                      isShow: isPasswordVisible,
                      isConfirmPassword: true,
                      confirmPassword: _passwordController.text,
                    ),
                    Gap(10),
                    CustomButton(
                      text: 'Register',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          AppLocalStorage.cacheData('name', nameController.text);
                          AppLocalStorage.cacheData(
                              'password', _passwordController.text);
                          pushReplacement(context, const HomeScreen());
                        }
                      },
                    ),
                  ],
                ),
              ),
              Gap(10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already Have An Account?'),
                  Gap(4),
                  TextButton(
                    onPressed: () {
                      push(context, LoginScreen());
                    },
                    child: Text('Login'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
