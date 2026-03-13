import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:todo/core/function/navigation.dart';
import 'package:todo/core/utlis/app_assets.dart';
import 'package:todo/core/utlis/app_color.dart';
import 'package:todo/features/task/view/add_task_screen.dart';
import 'package:todo/features/widgets/header.dart';
import 'package:todo/features/settings/view/profile_screen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              GestureDetector(onTap: () => push(context, ProfileScreen()),child: Header()),
              Gap(40),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("There are no tasks yet,"),
                    Text("Press the button"),
                    Text("add New Task "),
                  ],
                ),
              ),
              Center(
                child: SvgPicture.asset(
                  AppAssets.task,
                  height: 268,
                  width: 268,
                ),
              ),
              Gap(100),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColor.primaryColor,
                    child: IconButton(
                      onPressed: () {
                        push(context, AddTaskScreen());
                      },
                      icon: Icon(Icons.note_add_outlined),
                      color: Colors.white,
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
