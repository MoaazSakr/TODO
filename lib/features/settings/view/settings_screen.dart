import 'package:flutter/material.dart';
import 'package:todo/core/utlis/app_color.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isArabic = false;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Settings'), centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text('Language', style: TextStyle(fontSize: 24)),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isArabic = !isArabic;
                      });
                    },
                    child: Container(
                      width: 51,
                      height: 36,
                      decoration: BoxDecoration(
                        color: isArabic
                            ? AppColor.primaryColor
                            : AppColor.secondaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      child: Center(child: Text('Ar',)),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isArabic = !isArabic;
                      });
                    },
                    child: Container(
                      width: 51,
                      height: 36,
                      decoration: BoxDecoration(
                        color: isArabic
                            ? AppColor.secondaryColor
                            : AppColor.primaryColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Center(child: Text('En',)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
