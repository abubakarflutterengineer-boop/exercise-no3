import 'package:crud/constants/app_colors.dart';
import 'package:crud/constants/app_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final VoidCallback onDelete;

  const CustomAlertDialog({super.key, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 370,
        padding: const EdgeInsets.only(
          top: 22,
          left: 20,
          right: 20,
          bottom: 10,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              AppStrings.delete_student,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.text,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              AppStrings.sure_delete,
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.secondaryText, fontSize: 15),
            ),
            const SizedBox(height: 20),
            const Divider(color: AppColors.divider, height: 1),
            SizedBox(
              height: 48,
              child: Row(
                children: [
                  Expanded(
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        AppStrings.cancel,
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const VerticalDivider(color: AppColors.divider, width: 1),
                  Expanded(
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: onDelete,
                      child: const Text(
                        AppStrings.delete,
                        style: TextStyle(
                          color: AppColors.error,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
