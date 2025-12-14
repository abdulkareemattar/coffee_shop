import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:coffee_shop/gen/assets.gen.dart';
import '../utils/app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.white,
      fontFamily: Assets.fonts.soraRegular,

      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.lightBrown,
        surface: AppColors.white,
        background: Color(0xFFFAFAFA),
        error: Colors.red,
        onPrimary: AppColors.white,
        onSecondary: AppColors.primary,
        onSurface: AppColors.darkGrey,
        onBackground: AppColors.darkGrey,
        brightness: Brightness.light,
      ),

      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontSize: 34.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.darkGrey,
        ),
        headlineMedium: TextStyle(
          fontSize: 28.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.darkGrey,
        ),
        headlineSmall: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.darkGrey,
        ),

        bodyLarge: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.darkGrey,
        ),
        bodyMedium: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.darkGrey,
        ),
        bodySmall: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: Colors.grey.shade600,
        ),

        labelLarge: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          minimumSize: Size(double.infinity, 55.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          textStyle: TextStyle(
            fontFamily: Assets.fonts.soraSemiBold,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey.shade400,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF9F9F9),
        contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide.none,
        ),
        hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey.shade500),
      ),
    );
  }
}
