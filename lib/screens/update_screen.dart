import 'package:crud/constants/app_colors.dart';
import 'package:crud/constants/app_strings.dart';
import 'package:crud/database/db_helper.dart';
import 'package:crud/widgets/custom_elevated_button.dart';
import 'package:crud/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class UpdateScreen extends StatefulWidget {
  final Map<String, dynamic> student;
  const UpdateScreen({super.key, required this.student});
  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}
class _UpdateScreenState extends State<UpdateScreen> {
  final nameController = TextEditingController();
  final rollNoController = TextEditingController();
  final departmentController = TextEditingController();
  final marksController = TextEditingController();
  @override
  void initState() {
    super.initState();
    nameController.text = widget.student['Name']?.toString() ?? '';
    rollNoController.text = widget.student['rollNo']?.toString() ?? '';
    departmentController.text = widget.student['department']?.toString() ?? '';
    marksController.text = widget.student['marks']?.toString() ?? '';
  }
  Future<void> updateStudent() async {
    final String name = nameController.text.trim();
    final String rollNo = rollNoController.text.trim();
    final String department = departmentController.text.trim();
    final String marksText = marksController.text.trim();

    if (name.isEmpty ||
        rollNo.isEmpty ||
        department.isEmpty ||
        marksText.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
      return;
    }
    final int? marks = int.tryParse(marksText);
    if (marks == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter valid marks')));
      return;
    }
    final int? id = int.tryParse(widget.student['Id'].toString());
    if (id == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Invalid student ID')));
      return;
    }
    final int result = await DbHelper().updateStudent(
      id: id,
      name: name,
      rollNo: rollNo,
      department: department,
      marks: marks,
    );
    if (!mounted) {
      return;
    }
    if (result > 0) {
      Get.back(result: true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No student record was updated')),
      );
    }
  }
  @override
  void dispose() {
    nameController.dispose();
    rollNoController.dispose();
    departmentController.dispose();
    marksController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        foregroundColor: AppColors.text,
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'Update Student',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.cyan,
            size: 24,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Image.asset(
              'assets/images/database.png',
              height: 30,
              width: 30,
              color: AppColors.darkCyan,
            ),
          ),
        ],
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.container,
                borderRadius: BorderRadius.circular(20),
              ),
              height: 430,
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextFormField(
                      label: AppStrings.name,
                      hint: AppStrings.student_name,
                      icon: Icons.person,
                      controller: nameController,
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 18),
                    CustomTextFormField(
                      label: AppStrings.rollNo,
                      hint: AppStrings.student_rollNo,
                      icon: Icons.numbers,
                      controller: rollNoController,
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 18),
                    CustomTextFormField(
                      label: AppStrings.department,
                      hint: AppStrings.student_department,
                      icon: Icons.room,
                      controller: departmentController,
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 18),
                    CustomTextFormField(
                      label: AppStrings.marks,
                      hint: AppStrings.student_marks,
                      icon: Icons.numbers_sharp,
                      controller: marksController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 30),
                    CustomElevatedButton(
                      text: AppStrings.update_student,
                      icon: Icons.edit,
                      onPressed: updateStudent,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
