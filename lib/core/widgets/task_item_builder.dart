import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/utlis/app_color.dart';
import 'package:todo/features/home/data/task_model.dart';

class TaskItemBuilder extends StatelessWidget {
  const TaskItemBuilder({super.key, required this.task});
  final TaskModel task;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: AppColor.backgroundColor,
        boxShadow: [
          BoxShadow(
            offset: Offset.zero,
            blurRadius: 4.r,
            spreadRadius: 0,
            color: AppColor.blackColor.withAlpha(60)
          )
        ]
      ),
      padding: REdgeInsets.symmetric(
        horizontal: 12,
        vertical: 13
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(task.title??"",
                style: TextStyle(
                  color: AppColor.greyColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp
                ),),
                SizedBox(height: 13.h,),
                Text(task.description??"",
                  style: TextStyle(
                      color: AppColor.textColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp
                  ),),
              ],
            ),
          ),
          SizedBox(width: 20.w,),
          Text(task.createdAt??"",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColor.greyColor,
                fontWeight: FontWeight.w400,
                fontSize: 12.sp
            ),),
        ],
      ),
    );
  }
}