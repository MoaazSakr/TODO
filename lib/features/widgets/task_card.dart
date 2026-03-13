import 'package:flutter/material.dart';
import 'package:todo/core/utlis/app_color.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text('Task Title'),
          Text('Task Description'),
          Text('Group'),
          Text('End Time'),
        ],
      ),
    );
  }
}