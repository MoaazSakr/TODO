import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo/core/utlis/app_color.dart';

class SettingsContainer extends StatelessWidget {
  const SettingsContainer({super.key,required this.text,required this.icon,required this.onTap});
  final String? text;
  final IconData? icon;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon),
            Gap(10),
            Text(text??''),
            Spacer(),
            IconButton(onPressed: onTap, icon: Icon(Icons.arrow_forward_ios)),
          ],
        ),
      ),
    );
  }
}
