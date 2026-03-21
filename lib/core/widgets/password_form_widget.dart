import 'package:flutter/material.dart';
import 'package:todo/core/utlis/app_color.dart';

class PasswordFormWidget extends StatefulWidget {
  PasswordFormWidget({super.key, required this.isShow,required this.isConfirmPassword,this.confirmPassword });
  bool isShow;
  bool isConfirmPassword;
  final confirmPassword;
  @override
  State<PasswordFormWidget> createState() => _PasswordFormWidgetState();
}

class _PasswordFormWidgetState extends State<PasswordFormWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      validator:widget.isConfirmPassword?(value) {
        if (value?.isEmpty == true && value!.length < 6&&value!=widget.confirmPassword) {
          return 'please enter your password';
        }
        return null;
      }:(value) {
        if (value?.isEmpty == true && value!.length < 6) {
          return 'please enter your password';
        }
        return null;
      }, 
      obscureText:widget.isShow ,
      decoration: InputDecoration(
        hintText: 'enter your password',
        prefixIcon: Icon(Icons.lock,),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              widget.isShow = !widget.isShow;
            });
          },
          icon: Icon(widget.isShow ? Icons.key_off : Icons.key),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColor.primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColor.primaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColor.errorColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColor.errorColor),
        ),
      ),
    );
  }
}
