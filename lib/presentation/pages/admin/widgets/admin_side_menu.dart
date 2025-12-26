import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:coffee_shop/core/utils/app_colors.dart';

class AdminSideMenu extends StatelessWidget {
  const AdminSideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 250.w,
      color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      child: Column(
        children: [
          SizedBox(height: 50.h),
          // Logo Area
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.dashboard,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kaffein',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Admin Panel',
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 40.h),

          // Menu Items
          _buildMenuItem(
            context,
            icon: Icons.analytics_outlined,
            label: 'Dashboard',
            path: '/admin',
            isSelected: location == '/admin',
          ),
          _buildMenuItem(
            context,
            icon: Icons.coffee_outlined,
            label: 'Products',
            path: '/admin/products',
            isSelected: location.startsWith('/admin/products'),
          ),
          _buildMenuItem(
            context,
            icon: Icons.category_outlined,
            label: 'Categories',
            path: '/admin/categories',
            isSelected: location.startsWith('/admin/categories'),
          ),

          const Spacer(),

          // Logout
          Padding(
            padding: EdgeInsets.all(20.w),
            child: _buildMenuItem(
              context,
              icon: Icons.logout,
              label: 'Exit Admin',
              path: '/home',
              isSelected: false,
              isLogout: true,
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String path,
    required bool isSelected,
    bool isLogout = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => context.go(path),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          decoration: BoxDecoration(
            border: isSelected
                ? Border(
                    right: BorderSide(color: AppColors.primary, width: 4.w),
                  )
                : null,
            color: isSelected
                ? AppColors.primary.withOpacity(0.1)
                : Colors.transparent,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 20.sp,
                color: isSelected
                    ? AppColors.primary
                    : (isLogout ? Colors.red : Colors.grey),
              ),
              SizedBox(width: 12.w),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color: isSelected
                      ? AppColors.primary
                      : (isLogout
                            ? Colors.red
                            : (isDark ? Colors.white70 : Colors.grey[700])),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
