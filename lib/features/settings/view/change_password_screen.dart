import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo/core/function/password_validate.dart';
import 'package:todo/core/network/api_helper.dart';
import 'package:todo/core/utlis/app_assets.dart';
import 'package:todo/core/utlis/app_color.dart';
import 'package:todo/core/widgets/custom_button.dart';
import 'package:todo/core/widgets/custom_form_widget.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});
  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  void changePassword() async {
    if (_formKey.currentState?.validate() == true) {
      setState(() => _isLoading = true);
      var result = await APIHelper.changePassword(
        currentPassword: _oldPasswordController.text,
        newPassword: _newPasswordController.text,
        newPasswordConfirm: _confirmPasswordController.text,
      );
      result.fold(
        (error) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error), backgroundColor: AppColor.errorColor)),
        (success) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(success), backgroundColor: AppColor.primaryColor));
          Navigator.pop(context);
        }
      );
      setState(() => _isLoading = false);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Change Password'), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppAssets.logo), 
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomFormWidget(
                      text: 'Old Password',
                      controller: _oldPasswordController,
                      prefixIconPath: AppIcons.password,
                      validate: (value) {
                        if (value == null || value.isEmpty) return 'Enter old password';
                        return null;
                      },
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    Gap(10),
                    CustomFormWidget(
                      text: 'New Password',
                      controller: _newPasswordController,
                      prefixIconPath: AppIcons.password,
                      validate: (value) {
                        String? errorMessage = validatePassword(value);
                        if (errorMessage != null) {
                          return errorMessage;
                        }
                        return null;
                      },
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    Gap(10),
                    CustomFormWidget(
                      text: 'Confirm Password',
                      controller: _confirmPasswordController,
                      prefixIconPath: AppIcons.password,
                      validate: (value) {
                        if (value != _newPasswordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    Gap(20),
                    _isLoading
                        ? CircularProgressIndicator(color: AppColor.primaryColor)
                        : CustomButton(
                            text: 'Save',
                            onPressed: changePassword,
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}