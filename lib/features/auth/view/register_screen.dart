import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:todo/core/function/password_validate.dart';
import 'package:todo/core/network/api_helper.dart';
import 'package:todo/core/utlis/app_assets.dart';
import 'package:todo/core/utlis/app_color.dart';
import 'package:todo/features/auth/data/user_model.dart';
import 'package:todo/features/auth/view/login_screen.dart';
import 'package:todo/features/home/view/home_screen.dart';
import 'package:todo/core/widgets/custom_button.dart';
import 'package:todo/core/widgets/custom_form_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool isLoading = false;
  
  void register() async {
    if (_formKey.currentState?.validate() == true) {
      setState(() {
        isLoading = true;
      });
      
      var result = await APIHelper.register(
        username: _nameController.text,
        password: _passwordController.text,
      );
      
      result.fold(
        (String error) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error, style: const TextStyle(color: AppColor.backgroundColor)),
              backgroundColor: AppColor.errorColor,
            ),
          );
        },
        (UserModel userModel) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Registration successful\n Welcome ${userModel.username}', style: const TextStyle(color: AppColor.backgroundColor)),
              backgroundColor: AppColor.primaryColor,
            ),
          );
          
          // التوجيه المباشر للشاشة الرئيسية 
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen(userModel: userModel)),
            (route) => false,
          );
        },
      );
      
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 298.h, // استخدام .h لتكون متجاوبة
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppAssets.logo),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0.r), // استخدام .r لضبط الحواف والمسافات
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomFormWidget(
                        text: 'Name',
                        controller: _nameController,
                        keyboardType: TextInputType.name,
                        prefixIconPath: AppIcons.person,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      Gap(10.h),
                      CustomFormWidget(
                        text: 'Password',
                        controller: _passwordController,
                        prefixIconPath: AppIcons.password,
                        isPassword: true,
                        validate: (value) {
                          String? errorMessage = validatePassword(value);
                          if (errorMessage != null) {
                            return errorMessage;
                          }
                          return null;
                        },
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      Gap(10.h),
                      CustomFormWidget(
                        text: 'Confirm Password',
                        prefixIconPath: AppIcons.password,
                        isPassword: true,
                        validate: (value) {
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },),
                      Gap(20.h),
                      isLoading 
                          ? const CircularProgressIndicator(color: AppColor.primaryColor)
                          : CustomButton(
                              text: 'Register',
                              onPressed: register,
                            ),
                    ],
                  ),
                ),
              ),
              Gap(10.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already Have An Account?', style: TextStyle(fontSize: 14.sp)),
                  Gap(4.w),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context, 
                        MaterialPageRoute(builder: (context) => const LoginScreen())
                      );
                    },
                    child: Text('Login', style: TextStyle(color: AppColor.primaryColor, fontSize: 14.sp, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              Gap(20.h),
            ],
          ),
        ),
      ),
    );
  }
}