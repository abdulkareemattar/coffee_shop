import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:coffee_shop/presentation/pages/admin/widgets/admin_scaffold.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: 'Dashboard',
      body: SingleChildScrollView(
        child: Column(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 800) {
                  return Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          title: 'Total Sales',
                          value: '\$14,520',
                          trend: '+12%',
                          color: Colors.blue,
                          icon: Icons.attach_money,
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Expanded(
                        child: _StatCard(
                          title: 'Orders',
                          value: '350',
                          trend: '+5%',
                          color: Colors.orange,
                          icon: Icons.shopping_bag_outlined,
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Expanded(
                        child: _StatCard(
                          title: 'Products',
                          value: '45',
                          trend: '0%',
                          color: Colors.green,
                          icon: Icons.coffee,
                        ),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      _StatCard(
                        title: 'Total Sales',
                        value: '\$14,520',
                        trend: '+12%',
                        color: Colors.blue,
                        icon: Icons.attach_money,
                      ),
                      SizedBox(height: 16.h),
                      _StatCard(
                        title: 'Orders',
                        value: '350',
                        trend: '+5%',
                        color: Colors.orange,
                        icon: Icons.shopping_bag_outlined,
                      ),
                      SizedBox(height: 16.h),
                      _StatCard(
                        title: 'Products',
                        value: '45',
                        trend: '0%',
                        color: Colors.green,
                        icon: Icons.coffee,
                      ),
                    ],
                  );
                }
              },
            ),
            SizedBox(height: 30.h),
            // Placeholder for Charts or Recent Orders
            Container(
              height: 400.h,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: const Center(child: Text('Sales Chart Placeholder')),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String trend;
  final Color color;
  final IconData icon;

  const _StatCard({
    required this.title,
    required this.value,
    required this.trend,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(icon, color: color, size: 24.sp),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  trend,
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            value,
            style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4.h),
          Text(
            title,
            style: TextStyle(color: Colors.grey, fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}
