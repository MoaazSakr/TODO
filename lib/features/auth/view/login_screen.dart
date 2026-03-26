import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo/core/function/navigation.dart';
import 'package:todo/core/function/password_validate.dart';
import 'package:todo/core/network/api_helper.dart';
import 'package:todo/core/utlis/app_assets.dart';
import 'package:todo/core/utlis/app_color.dart';
import 'package:todo/features/auth/data/user_model.dart';
import 'package:todo/features/home/view/home_screen.dart';
import 'package:todo/features/auth/view/register_screen.dart';
import 'package:todo/core/widgets/custom_button.dart';
import 'package:todo/core/widgets/custom_form_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  void login() async {}
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = true;
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  bool isLoading = false;
  
  login() async{
    if(_formKey.currentState?.validate() == true){
      setState(() {
        isLoading = true;
      });
      var result = await APIHelper.login
      (username: _nameController.text, password: _passwordController.text);
      result.fold(
          (String error){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(error, style: TextStyle(color: AppColor.backgroundColor),),
              backgroundColor: AppColor.errorColor,
            ));
          },
          (UserModel userModel){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Login successfully\n Welcome ${userModel.username}', style: TextStyle(color: AppColor.backgroundColor),),
              backgroundColor: AppColor.primaryColor,
            ));
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context)=> HomeScreen(userModel: userModel,)),
                (r)=> false
            );
          }
      );
      setState(() {
        isLoading = false;
      });
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
                height: 298,
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
                        text: 'Name',
                        controller: _nameController,
                        prefixIconPath: AppIcons.person,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                      ),
                      Gap(10),
                     CustomFormWidget(
                        text: 'Password',
                        controller: _passwordController,
                        prefixIconPath: AppIcons.password,
                        validate: (value) {
                          String? errorMessage = validatePassword(value);
                          if (errorMessage != null) {
                            return errorMessage;
                          }
                          _passwordController.text = value ?? '';
                          return null;
                        },
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      Gap(20),
                      isLoading 
                          ? CircularProgressIndicator(color: AppColor.primaryColor)
                          : CustomButton(
                              text: 'Login',
                              onPressed: login,
                            ),
                    ],
                  ),
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
                    child: Text('Register', style: TextStyle(color: AppColor.primaryColor)),
                  ),
                ],
              ),
              Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}