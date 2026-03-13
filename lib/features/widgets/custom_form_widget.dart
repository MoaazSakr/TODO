import 'package:flutter/material.dart';
import 'package:todo/core/utlis/app_color.dart';

// ignore: must_be_immutable
class CustomFormWidget extends StatelessWidget {
  CustomFormWidget({
    super.key,
    required this.text,
    this.icon,
    required this.validate,
    required this.keyboardType,
    this.isDescription =false
  });
  final String text;
  final IconData? icon;
  final TextInputType keyboardType;
  final String? Function(String?) validate;
  bool isDescription;
  @override
  Widget build(BuildContext context) {
    var inputDecoration2 = InputDecoration(
      hintText: 'enter your $text',
      prefixIcon: Icon(icon),
      fillColor: AppColor.backgroundColor,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColor.greyColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColor.greyColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColor.errorColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColor.errorColor),
      ),
    );
    var inputDecoration = inputDecoration2;
    return TextFormField(
      keyboardType:  keyboardType,
      validator: validate,
      decoration: inputDecoration,
      maxLines:isDescription ? 4:1 ,
    );
  }
}
