import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:coffee_shop/core/utils/app_colors.dart';
import 'package:coffee_shop/data/models/coffee_model.dart';
import 'package:go_router/go_router.dart';
import 'package:coffee_shop/presentation/common/buttons/outlined_primary_button.dart';
import 'package:coffee_shop/presentation/common/buttons/primary_button.dart';

class DetailsBottomBar extends StatelessWidget {
  final CoffeeModel coffeeModel;
  final VoidCallback onAddToCart;

  const DetailsBottomBar({
    super.key,
    required this.coffeeModel,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 118.h,
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Price',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade500,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                '\$ ${coffeeModel.price.toStringAsFixed(2)}',
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          Row(
            children: [
              OutlinedPrimaryButton(
                text: 'Add',
                onPressed: onAddToCart,
                borderColor: AppColors.primary,
                textColor: AppColors.primary,
                width: 100.w,
                height: 56.h,
              ),
              SizedBox(width: 12.w),
              PrimaryButton(
                text: 'Buy Now',
                onPressed: () {
                  context.push('/order', extra: coffeeModel);
                },
                width: 105.w,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
