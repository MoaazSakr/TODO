import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo/core/utlis/app_color.dart';

// ignore: must_be_immutable
class CustomFormWidget extends StatefulWidget {
  CustomFormWidget({
    super.key,
    this.prefixIconPath,
    required this.text,
    this.validate,
    this.keyboardType,
    this.isDescription = false,
    this.readOnly = false,
    this.onTap,
    this.controller,
    this.isPassword = false,
    this.isPasswordVisible = false,
  });

  final String? prefixIconPath;
  final String? text;
  final String? Function(String?)? validate;
  final TextInputType? keyboardType;
  final bool isDescription;
  final bool readOnly;
  final void Function()? onTap;
  final TextEditingController? controller;
  bool isPassword;
  bool isPasswordVisible = false;

  @override
  State<CustomFormWidget> createState() => _CustomFormWidgetState();
}

class _CustomFormWidgetState extends State<CustomFormWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      maxLines: widget.isDescription ? 4 : 1, // تكبير الحقل إذا كان للوصف
      style: TextStyle(
        color: AppColor.textColor,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        hintText: widget.text, // تعديل الـ hint ليكون متطابق مع التصميم
        hintStyle: TextStyle(
          color: AppColor.greyColor,
          fontSize: 14.sp,
          fontWeight: FontWeight.w100,
        ),
        prefixIcon: widget.prefixIconPath == null
            ? null
            : Padding(
                padding: const EdgeInsets.all(12.0),
                child: SvgPicture.asset(widget.prefixIconPath!),
              ),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    widget.isPasswordVisible = !widget.isPasswordVisible;
                  });
                },
                icon: Icon(
                  widget.isPasswordVisible
                      ? Icons.lock_open_rounded
                      : Icons.lock_outline_rounded,
                ),
              )
            : null,
        contentPadding: REdgeInsets.symmetric(horizontal: 16, vertical: 22),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: const BorderSide(color: AppColor.accentColor, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: const BorderSide(color: AppColor.accentColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: const BorderSide(color: AppColor.primaryColor, width: 1),
        ),
      ),
      validator: widget.validate,
      keyboardType: widget.isPassword ? TextInputType.visiblePassword : widget.keyboardType,
      obscureText: widget.isPassword && !widget.isPasswordVisible,
    );
  }
}
