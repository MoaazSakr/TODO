import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo/core/utlis/app_color.dart';

class CustomFormWidget extends StatelessWidget {
  CustomFormWidget({
    super.key,
    this.prefixIconPath,
    required this.text,
    this.validate,
    required this.keyboardType,
    this.isDescription = false,
    this.readOnly = false,
    this.onTap,
    this.controller,
  });

  final String? prefixIconPath;
  final String? text;
  final String? Function(String?)? validate;
  final TextInputType keyboardType;
  final bool isDescription;
  final bool readOnly;
  final void Function()? onTap;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      maxLines: isDescription ? 4 : 1, // تكبير الحقل إذا كان للوصف
      style: TextStyle(
          color: AppColor.textColor,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400),
      decoration: InputDecoration(
        hintText: text, // تعديل الـ hint ليكون متطابق مع التصميم
        hintStyle: TextStyle(
            color: AppColor.greyColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w100),
        prefixIcon: prefixIconPath == null
            ? null
            : Padding(
                padding: const EdgeInsets.all(12.0),
                child: SvgPicture.asset(prefixIconPath!),
              ),
        contentPadding: REdgeInsets.symmetric(horizontal: 16, vertical: 22),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: const BorderSide(color: AppColor.accentColor, width: 1)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: const BorderSide(color: AppColor.accentColor, width: 1)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: const BorderSide(color: AppColor.primaryColor, width: 1)),
      ),
      validator: validate,
      keyboardType: keyboardType,
    );
  }
}