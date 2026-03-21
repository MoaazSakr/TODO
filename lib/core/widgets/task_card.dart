import 'package:flutter/material.dart';
import 'package:todo/core/utlis/app_color.dart';
import 'package:todo/features/home/data/task_model.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task});
  final TaskModel task;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(task.title??""),
          Text(task.description??""),
          Text(task.group??""),
          Text(task.createdAt??""),
        ],
      ),
    );
  }
}