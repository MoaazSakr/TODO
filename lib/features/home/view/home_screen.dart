import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:todo/core/function/navigation.dart';
import 'package:todo/core/network/api_helper.dart';
import 'package:todo/core/utlis/app_assets.dart';
import 'package:todo/core/utlis/app_color.dart';
import 'package:todo/features/auth/data/user_model.dart';
import 'package:todo/features/home/data/task_model.dart';
import 'package:todo/features/task/view/add_task_screen.dart';
import 'package:todo/core/widgets/header.dart';
import 'package:todo/core/widgets/task_item_builder.dart';
import 'package:todo/features/task/view/edit_task_screen.dart';
import 'package:todo/features/settings/view/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.userModel});
  
  final UserModel? userModel;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TaskModel> tasks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  void fetchTasks() async {
    setState(() => isLoading = true);
    var result = await APIHelper.getTasks();
    result.fold(
      (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error), backgroundColor: AppColor.errorColor)
        );
        setState(() => isLoading = false);
      },
      (tasksList) {
        setState(() {
          tasks = tasksList;
          isLoading = false;
        });
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await push(context, const AddTaskScreen());
          fetchTasks(); 
        },
        backgroundColor: AppColor.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: SvgPicture.asset(AppIcons.addTask, height: 24, width: 24),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => push(context, const ProfileScreen()),
                child: Header()
              ),
              const Gap(20),
              Expanded(
                child: isLoading 
                    ? const Center(child: CircularProgressIndicator(color: AppColor.primaryColor))
                    : tasks.isEmpty
                        ? RefreshIndicator(
                            onRefresh: () async => fetchTasks(),
                            color: AppColor.primaryColor,
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Gap(80),
                                  const Text(
                                    "There are no tasks yet,\nPress the button\nTo add New Task", 
                                    textAlign: TextAlign.center, 
                                    style: TextStyle(color: AppColor.greyColor, fontSize: 16)
                                  ),
                                  const Gap(20),
                                  SvgPicture.asset(AppAssets.task, height: 268, width: 268),
                                ],
                              ),
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: () async => fetchTasks(),
                            color: AppColor.primaryColor,
                            child: ListView.separated(
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: tasks.length,
                              separatorBuilder: (context, index) => const Gap(15),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () async {
                                    await push(context, EditTaskScreen(task: tasks[index]));
                                    fetchTasks(); 
                                  },
                                  child: TaskItemBuilder(task: tasks[index]),
                                );
                              },
                            ),
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}