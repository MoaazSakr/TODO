import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo/core/network/api_helper.dart';
import 'package:todo/core/utlis/app_color.dart';
import 'package:todo/core/widgets/custom_button.dart';
import 'package:todo/core/widgets/custom_form_widget.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();

  final List<String> _groups = ['Home', 'Personal', 'Work'];
  
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  String? _selectedGroup;
  bool _isLoading = false;

  void _submitTask() async {
    if (_formKey.currentState!.validate()) {
      setState(() { _isLoading = true; });

      var result = await APIHelper.addTask(
        title: _titleController.text,
        description: _descriptionController.text,
        group: _selectedGroup,
        endTime: _endTimeController.text,
      );

      result.fold(
        (error) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error), backgroundColor: AppColor.errorColor)),
        (success) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(success), backgroundColor: AppColor.primaryColor));
          Navigator.pop(context); 
        }
      );

      setState(() { _isLoading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Task'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomFormWidget(
                text: 'Task Title', 
                controller: _titleController,
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a task title';
                  }
                  return null;
                }, keyboardType: TextInputType.text),
              const Gap(10),
              CustomFormWidget(
                text: 'Task Description', 
                controller: _descriptionController,
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a task description';
                  }
                  return null;
                }, keyboardType: TextInputType.text, isDescription: true),         
              const Gap(10),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: AppColor.accentColor, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: AppColor.accentColor, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: AppColor.primaryColor, width: 1),
                  ),
                ),
                hint: const Text('Select a Group'),
                items: _groups.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), 
                onChanged: (value){
                  setState(() {
                    _selectedGroup = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a group';
                  }
                  return null;
                },
              ),
              const Gap(10),
              CustomFormWidget(
                text: 'End Time', 
                controller: _endTimeController,
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a task date';
                  }
                  return null;
                }, keyboardType: TextInputType.datetime),
              const Gap(30),
              _isLoading 
                  ? const CircularProgressIndicator(color: AppColor.primaryColor)
                  : CustomButton(text: 'Add Task', onPressed: _submitTask),
            ],
          ),
        ),
      ),
    );
  }
}