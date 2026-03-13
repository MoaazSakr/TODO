import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo/core/function/navigation.dart';
import 'package:todo/core/services/local_helper.dart';
import 'package:todo/core/utlis/app_assets.dart';
import 'package:todo/features/settings/view/profile_screen.dart';
import 'package:todo/features/widgets/custom_button.dart';
import 'package:todo/features/widgets/password_form_widget.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});
  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}


class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isShow=false;
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  String _checkPasswordController = AppLocalStorage.getData('password');
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.asset(AppAssets.logo, width: double.infinity, height: 298),
                Gap(10),
                PasswordFormWidget(isShow: isShow, isConfirmPassword: false,
                ),
                Gap(20),
               PasswordFormWidget(
                      isShow: isShow,
                      isConfirmPassword: false,
                    ),
                    Gap(10),
                    PasswordFormWidget(
                      isShow: isShow,
                      isConfirmPassword: true,
                      confirmPassword: _newPasswordController.text,
                    ),
                CustomButton(
                  text: 'Update',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (_passwordController.text == _checkPasswordController) {
                        AppLocalStorage.setData('password', _newPasswordController.text);
                        pop(context, ProfileScreen());
                      }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Password is not correct'),
                          ),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
