import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:todo/core/network/api_helper.dart';
import 'package:todo/core/utlis/app_color.dart';
import 'package:todo/core/utlis/app_assets.dart';
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

  final List<String> _groups = ['Work', 'Personal', 'Home'];
  
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _endTimeController;
  
  String? _selectedGroup;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // تعبئة البيانات الحالية للمهمة في الحقول
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController = TextEditingController(text: widget.task.description ?? '');
    _endTimeController = TextEditingController(text: widget.task.endTime ?? '');
    
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
        (error) {
          if(!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error), backgroundColor: AppColor.errorColor));
        },
        (success) {
          if(!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(success), backgroundColor: AppColor.primaryColor));
          Navigator.pop(context);
        }
      );
      if(mounted) setState(() => _isLoading = false);
    }
  }

  void _deleteTask() async {
    if (widget.task.id != null) {
      setState(() => _isLoading = true);
      var result = await APIHelper.deleteTask(taskId: widget.task.id!);
      result.fold(
        (error) {
          if(!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error), backgroundColor: AppColor.errorColor));
        },
        (success) {
          if(!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(success), backgroundColor: AppColor.primaryColor));
          Navigator.pop(context);
        }
      );
      if(mounted) setState(() => _isLoading = false);
    }
  }

  // دالة مساعدة لتحديد الأيقونة المناسبة لكل مجموعة
  String _getGroupIconString(String groupName) {
    if (groupName == 'Work') return AppIcons.workGroup;
    if (groupName == 'Personal') return AppIcons.personGroup;
    return AppIcons.homeGroup;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA), // لون خلفية الشاشة
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Edit Task', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500)), 
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
          actions: [
            IconButton(
              onPressed: _deleteTask,
              icon: const Icon(Icons.delete_outline, color: AppColor.errorColor),
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // الصورة العلوية
                Container(
                  height: 220,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    image: const DecorationImage(
                      image: AssetImage(AppAssets.logo), 
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      )
                    ]
                  ),
                ),
                const Gap(30),

                // حقل العنوان
                CustomFormWidget(
                  text: 'Title', 
                  controller: _titleController,
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a task title';
                    }
                    return null;
                  }, 
                  keyboardType: TextInputType.text
                ),
                const Gap(16),

                // حقل الوصف
                CustomFormWidget(
                  text: 'Description', 
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
                const Gap(16),

                // قائمة اختيار المجموعة بتصميم الأيقونات
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
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
                  hint: const Text('Group', style: TextStyle(color: Colors.grey)),
                  icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black87),
                  value: _selectedGroup,
                  items: _groups.map((String group) {
                    return DropdownMenuItem<String>(
                      value: group,
                      child: Row(
                        children: [
                          SvgPicture.string(
                            _getGroupIconString(group), 
                            width: 24, 
                            height: 24
                          ),
                          const Gap(12),
                          Text(group, style: const TextStyle(fontWeight: FontWeight.w500)),
                        ],
                      ),
                    );
                  }).toList(),
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
                const Gap(16),

                // حقل وقت الانتهاء (End Time)
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
                const Gap(40),

                // زر التحديث
                _isLoading 
                    ? const CircularProgressIndicator(color: AppColor.primaryColor)
                    : CustomButton(text: 'Update Task', onPressed: _updateTask),
                
                const Gap(20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}