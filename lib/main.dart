import 'package:coffee_shop/app/app_colors.dart';
import 'package:coffee_shop/cubit/favorites_cubit.dart';
import 'package:coffee_shop/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoritesCubit()..loadFavorites(),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            home: OnboardingScreen(),
          );
        },
      ),
    );
  }
}

// The AppColors and AppTheme classes that we moved here before
class AppColors {
  static const Color primary = Color(0xFFC67C4E);
  static const Color lightBrown = Color(0xFFEDD6C8);
  static const Color darkGrey = Color(0xFF313131);
  static const Color lightGrey = Color(0xFFE3E3E3);
  static const Color offWhite = Color(0xFFF9F2ED);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color green = Color(0xFF36C07E);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.white,
      fontFamily: 'Sora', // Assuming Sora is the font name you want to use
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
        headlineLarge: TextStyle(fontSize: 34.sp, fontWeight: FontWeight.w600, color: AppColors.darkGrey),
        headlineMedium: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w600, color: AppColors.darkGrey),
        headlineSmall: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600, color: AppColors.darkGrey),
        bodyLarge: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, color: AppColors.darkGrey),
        bodyMedium: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: AppColors.darkGrey),
        bodySmall: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color: Colors.grey.shade600),
        labelLarge: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.white),
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
            fontFamily: 'Sora', 
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
        hintStyle: TextStyle(
          fontSize: 14.sp,
          color: Colors.grey.shade500,
        ),
      ),
    );
  }
}
