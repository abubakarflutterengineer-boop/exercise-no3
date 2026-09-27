import 'package:crud/constants/app_colors.dart';
import 'package:crud/constants/app_strings.dart';
import 'package:crud/database/db_helper.dart';
import 'package:crud/widgets/custom_elevated_button.dart';
import 'package:crud/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final nameController = TextEditingController();
  final rollNoController = TextEditingController();
  final departmentController = TextEditingController();
  final marksController = TextEditingController();

  Future<void> addStudent() async {
    String name = nameController.text.trim();
    String rollNo = rollNoController.text.trim();
    String department = departmentController.text.trim();
    String marksText = marksController.text.trim();
    if (name.isEmpty ||
        rollNo.isEmpty ||
        department.isEmpty ||
        marksText.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }
    int marks = int.parse(marksText);
    await DbHelper().insertStudent(
      name: name,
      rollNo: rollNo,
      department: department,
      marks: marks,
    );
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Student added successfully")));
    Get.back();
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
          AppStrings.add,
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
            child: Center(
              child: Container(
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
                        text: AppStrings.save_student,
                        icon: Icons.save,
                        onPressed: addStudent,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
