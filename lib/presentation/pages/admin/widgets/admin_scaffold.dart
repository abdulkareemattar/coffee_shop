import 'package:flutter/material.dart';
import 'package:coffee_shop/presentation/pages/admin/widgets/admin_side_menu.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget? floatingActionButton;
  final List<Widget>? actions;

  const AdminScaffold({
    super.key,
    required this.title,
    required this.body,
    this.floatingActionButton,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    // Check if we are on a large screen (Tablets/Desktop)
    final isDesktop = MediaQuery.of(context).size.width >= 800;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF121212)
          : const Color(0xFFF4F6F9),
      appBar: !isDesktop
          ? AppBar(
              title: Text(title),
              backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
              elevation: 0,
              iconTheme: IconThemeData(
                color: isDark ? Colors.white : Colors.black,
              ),
              titleTextStyle: TextStyle(
                color: isDark ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
              actions: actions,
            )
          : null,
      drawer: !isDesktop ? const Drawer(child: AdminSideMenu()) : null,
      floatingActionButton: floatingActionButton,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Side Menu for Desktop
          if (isDesktop) const AdminSideMenu(),

          // Main Content
          Expanded(
            child: Column(
              children: [
                if (isDesktop)
                  Container(
                    height: 80.h,
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: isDark ? Colors.white10 : Colors.grey.shade200,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (actions != null && actions!.isNotEmpty)
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: actions!,
                          ),
                      ],
                    ),
                  ),
                Expanded(
                  child: Padding(padding: EdgeInsets.all(20.w), child: body),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
