import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo/core/function/navigation.dart';
import 'package:todo/core/utlis/app_assets.dart';
import 'package:todo/features/home/view/home_screen.dart';
import 'package:todo/features/auth/view/register_screen.dart';
import 'package:todo/core/widgets/custom_button.dart';
import 'package:todo/core/widgets/custom_form_widget.dart';
import 'package:todo/core/widgets/password_form_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = true;
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
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
                      icon: Icons.person,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        _nameController.text = value;
                        return null;
                      },
                      keyboardType: TextInputType.name,
                    ),
                    Gap(10),
                   PasswordFormWidget(isShow:isPasswordVisible, isConfirmPassword: true,confirmPassword:_passwordController ,),
                    Gap(10),
                    CustomButton(
                      text: 'Login',
                      onPressed: () {
                        if (_formKey.currentState?.validate() == true) {
                          if(_nameController.text.isNotEmpty&&_passwordController.text.isNotEmpty)
                            {pushReplacement(context, HomeScreen());}
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
                  Text("Don't Have An Account?"),
                  Gap(4),
                  TextButton(
                    onPressed: () {
                      push(context, RegisterScreen());
                    },
                    child: Text('Register'),
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
