import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:coffee_shop/core/utils/app_colors.dart';

class DeliveryToggle extends StatefulWidget {
  const DeliveryToggle({super.key});

  @override
  State<DeliveryToggle> createState() => DeliveryToggleState();
}

class DeliveryToggleState extends State<DeliveryToggle> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          _buildToggleItem(0, 'Deliver'),
          _buildToggleItem(1, 'Pick Up'),
        ],
      ),
    );
  }

  Widget _buildToggleItem(int index, String text) {
    bool isSelected = _selectedIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _selectedIndex = index),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Center(
            child: Text(
              text,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: isSelected ? AppColors.white : AppColors.darkGrey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
