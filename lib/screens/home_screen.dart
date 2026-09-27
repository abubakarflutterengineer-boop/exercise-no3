import 'package:crud/constants/app_colors.dart';
import 'package:crud/constants/app_strings.dart';
import 'package:crud/database/db_helper.dart';
import 'package:crud/routes/app_routes.dart';
import 'package:crud/widgets/custom_alert_dialog.dart';
import 'package:crud/widgets/custom_elevated_button.dart';
import 'package:crud/widgets/student_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> _students = [];
  Future<void> _loadStudents() async {
    final List<Map<String, dynamic>> students = await DbHelper()
        .getAllStudents();
    if (!mounted) {
      return;
    }
    setState(() {
      _students = students;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }
  Future<void> _addStudent() async {
    await Get.toNamed(AppRoutes.add);
    await _loadStudents();
  }
  Future<void> _editStudent(int index) async {
    await Get.toNamed(AppRoutes.edit, arguments: _students[index]);
    await _loadStudents();
  }
  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomAlertDialog(
          onDelete: () async {
            final int id = int.parse(_students[index]['Id'].toString());
            await DbHelper().deleteStudent(id);
            Get.back();
            await _loadStudents();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.text,
        elevation: 0,
        title: const Text(
          AppStrings.records,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomElevatedButton(
              text: AppStrings.add,
              icon: Icons.add,
              onPressed: _addStudent,
            ),
            const SizedBox(height: 28),
            const Text(
              AppStrings.allData,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(child: _students.isEmpty ? _emptyState() : _studentList()),
          ],
        ),
      ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: AppColors.lightCyan.withValues(alpha: 0.25),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.storage_outlined,
              size: 55,
              color: AppColors.darkCyan,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            AppStrings.no_student,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            AppStrings.add_first,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: AppColors.secondaryText),
          ),
        ],
      ),
    );
  }
  Widget _studentList() {
    return ListView.builder(
      itemCount: _students.length,
      itemBuilder: (context, index) {
        final Map<String, dynamic> student = _students[index];
        return StudentCard(
          name: student['Name']?.toString() ?? '',
          rollNo: student['rollNo']?.toString() ?? '',
          department: student['department']?.toString() ?? '',
          marks: student['marks']?.toString() ?? '',
          onEdit: () {
            _editStudent(index);
          },
          onDelete: () {
            _showDeleteDialog(index);
          },
        );
      },
    );
  }
}
