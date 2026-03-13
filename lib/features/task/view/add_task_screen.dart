import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo/features/widgets/custom_form_widget.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Task'), centerTitle: true),
      body: Column(
        children: [
         CustomFormWidget(text: 'Task Title', validate: (value) {
           if (value == null || value.isEmpty) {
             return 'Please enter a task title';
           }
           return null;
         }, keyboardType: TextInputType.text),
         Gap(10),
         CustomFormWidget(text: 'Task Description', validate: (value) {
           if (value == null || value.isEmpty) {
             return 'Please enter a task description';
           }
           return null;
         }, keyboardType: TextInputType.text,isDescription: true),         
         Gap(10),
         Container(
          child: ListTile(
            title: Text('Group'),
            trailing: RotatedBox(quarterTurns: 1,child: Icon(Icons.arrow_forward_ios)),
            onTap: (){
              showModalBottomSheet(context: context, builder: (context){
                return Container(
                  child: Column(
                    children: [
                      Text('Home'),
                      Text('Personal'),
                      Text('Work'),
                    ],
                  ),
                );
              });
            },
          ),
         ),
         Gap(10),
         CustomFormWidget(text: 'End Time', validate: (value) {
           if (value == null || value.isEmpty) {
             return 'Please enter a task date';
           }
           return null;
         }, keyboardType: TextInputType.datetime),
        ],
      ),
    );
  }
}
