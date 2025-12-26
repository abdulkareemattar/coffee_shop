import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:coffee_shop/core/utils/app_colors.dart';
import 'package:coffee_shop/presentation/common/buttons/primary_button.dart';
import 'package:coffee_shop/presentation/manager/cubit/theme/theme_cubit.dart';

class CartSummary extends StatelessWidget {
  final double total;
  final VoidCallback onCheckout;
  final VoidCallback onClearCart;

  const CartSummary({
    super.key,
    required this.total,
    required this.onCheckout,
    required this.onClearCart,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = context.isDarkMode;

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.2)
                : Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\$${total.toStringAsFixed(2)}',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  fontSize: 24.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          PrimaryButton(text: 'Checkout', onPressed: onCheckout),
          SizedBox(height: 12.h),
          TextButton(
            onPressed: onClearCart,
            child: Text(
              'Clear Cart',
              style: TextStyle(color: Colors.red, fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );
  }
}
