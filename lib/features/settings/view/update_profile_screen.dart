import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:todo/core/function/navigation.dart';
import 'package:todo/core/utlis/app_assets.dart';
import 'package:todo/features/settings/view/profile_screen.dart';
import 'package:todo/core/widgets/custom_button.dart';
import 'package:todo/core/widgets/custom_form_widget.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});
  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset(AppAssets.logo, width: double.infinity, height: 298),
                Gap(10),
                CustomFormWidget(
                  text: 'Username',
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    } else
                      return null;
                  },
                  keyboardType: TextInputType.name,
                ),
                Gap(20),
                CustomButton(
                  text: 'Update',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      pop(context, ProfileScreen());
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
