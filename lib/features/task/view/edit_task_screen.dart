import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo/core/network/api_helper.dart';
import 'package:todo/core/utlis/app_color.dart';
import 'package:todo/core/widgets/custom_button.dart';
import 'package:todo/core/widgets/custom_form_widget.dart';
import 'package:todo/features/home/data/task_model.dart';

class EditTaskScreen extends StatefulWidget {
  final TaskModel task;
  const EditTaskScreen({super.key, required this.task});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final _formKey = GlobalKey<FormState>();

  final List<String> _groups = ['Home', 'Personal', 'Work'];
  
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _endTimeController;
  String? _selectedGroup;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController = TextEditingController(text: widget.task.description);
    if (widget.task.group != null && _groups.contains(widget.task.group)) {
      _selectedGroup = widget.task.group;
    }
  }

  void _updateTask() async {
    if (_formKey.currentState!.validate() && widget.task.id != null) {
      setState(() => _isLoading = true);
      var result = await APIHelper.updateTask(
        taskId: widget.task.id!,
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
      setState(() => _isLoading = false);
    }
  }

  void _deleteTask() async {
    if (widget.task.id != null) {
      setState(() => _isLoading = true);
      var result = await APIHelper.deleteTask(taskId: widget.task.id!);
      result.fold(
        (error) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error), backgroundColor: AppColor.errorColor)),
        (success) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(success), backgroundColor: AppColor.primaryColor));
          Navigator.pop(context);
        }
      );
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'), 
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _deleteTask,
            icon: const Icon(Icons.delete_outline, color: AppColor.errorColor),
          )
        ],
      ),
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
                }, 
                keyboardType: TextInputType.text
              ),
              const Gap(10),
              CustomFormWidget(
                text: 'Task Description', 
                controller: _descriptionController,
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a task description';
                  }
                  return null;
                }, 
                keyboardType: TextInputType.text,
                isDescription: true
              ),         
              const Gap(10),
              DropdownButtonFormField<String>(
                value: _selectedGroup,
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
                  if (value == null) return 'Please select a group';
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
                }, 
                keyboardType: TextInputType.datetime
              ),
              const Gap(30),
              _isLoading 
                  ? const CircularProgressIndicator(color: AppColor.primaryColor)
                  : CustomButton(text: 'Update Task', onPressed: _updateTask),
            ],
          ),
        ),
      ),
    );
  }
}