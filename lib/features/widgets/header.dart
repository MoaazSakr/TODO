import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo/core/utlis/app_assets.dart';
import 'package:todo/core/services/local_helper.dart';
class Header extends StatefulWidget {
  const Header({super.key });
  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return 
        Row(
            children: [
              CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(AppAssets.logo),
          ),
          Gap(10),
          Text('Hello! \n${AppLocalStorage.getData('name')}'),
            ],
    );
  }
}
