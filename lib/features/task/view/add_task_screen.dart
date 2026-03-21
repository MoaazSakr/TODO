import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo/core/widgets/custom_form_widget.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();

  final List<String> _groups = ['Home', 'Personal', 'Work'];

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
          child: DropdownButtonFormField<String>(items: _groups.map((e) => DropdownMenuItem(value: e, child: Text(e),)).toList(), onChanged: (value){
            setState(() {
              _formKey.currentState!.validate();
            });

          },
          validator: (value) {
            if (value == null) {
              return 'Please select a group';
            }
            return null;
          },)
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
