import 'package:flutter/material.dart';
import 'package:todo/core/utlis/app_color.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key ,required this.text,required this.onPressed});
  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          shadowColor: AppColor.blackColor,
          elevation: 10,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: AppColor.backgroundColor,
            fontSize: 19,
            fontWeight: FontWeight.w300,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
