import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:coffee_shop/core/utils/app_colors.dart';
import 'package:coffee_shop/data/models/coffee_model.dart';

class OrderItem extends StatefulWidget {
  final CoffeeModel coffee;

  const OrderItem({super.key, required this.coffee});

  @override
  State<OrderItem> createState() => OrderItemState();
}

class OrderItemState extends State<OrderItem> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Image.asset(
            widget.coffee.imagePath,
            width: 54.w,
            height: 54.h,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.coffee.name, style: theme.textTheme.titleMedium),
            SizedBox(height: 4.h),
            Text(
              widget.coffee.type,
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
        const Spacer(),
        _buildQuantityButton(
          icon: Icons.remove,
          onTap: () {
            if (_quantity > 1) setState(() => _quantity--);
          },
        ),
        SizedBox(width: 12.w),
        Text(_quantity.toString(), style: theme.textTheme.titleMedium),
        SizedBox(width: 12.w),
        _buildQuantityButton(
          icon: Icons.add,
          onTap: () => setState(() => _quantity++),
        ),
      ],
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(4.r),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.lightGrey),
        ),
        child: Icon(icon, size: 16.sp, color: AppColors.darkGrey),
      ),
    );
  }
}
