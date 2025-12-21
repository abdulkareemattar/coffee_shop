import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSnackBar {
  static void showSuccess(BuildContext context, {required String message}) {
    _show(
      context,
      message,
      backgroundColor: const Color(0xFFE8F5E9),
      borderColor: const Color(0xFF4CAF50),
      iconColor: const Color(0xFF4CAF50),
      icon: Icons.check_circle_outline,
    );
  }

  static void showError(BuildContext context, {required String message}) {
    _show(
      context,
      message,
      backgroundColor: const Color(0xFFFFEBEE),
      borderColor: const Color(0xFFEF5350),
      iconColor: const Color(0xFFEF5350),
      icon: Icons.error_outline,
    );
  }

  static void showWarning(BuildContext context, {required String message}) {
    _show(
      context,
      message,
      backgroundColor: const Color(0xFFFFF8E1),
      borderColor: const Color(0xFFFFCA28),
      iconColor: const Color(0xFFFFCA28),
      icon: Icons.warning_amber_rounded,
    );
  }

  static void _show(
    BuildContext context,
    String message, {
    required Color backgroundColor,
    required Color borderColor,
    required Color iconColor,
    required IconData icon,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: iconColor),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          side: BorderSide(color: borderColor, width: 1),
        ),
        margin: EdgeInsets.all(16.w),
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        duration: const Duration(seconds: 4),
      ),
    );
  }
}
