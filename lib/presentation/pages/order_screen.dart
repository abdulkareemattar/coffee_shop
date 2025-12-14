import 'package:coffee_shop/core/utils/app_colors.dart';
import 'package:coffee_shop/data/models/coffee_model.dart';
import 'package:coffee_shop/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../widgets/action_button.dart';
import '../widgets/delivery_toggle.dart';
import '../widgets/discount_section.dart';
import '../widgets/order_item_card.dart';
import '../widgets/section_title.dart';

class OrderScreen extends StatelessWidget {
  final CoffeeModel coffee;

  const OrderScreen({super.key, required this.coffee});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            Assets.icons.typeRegularStateOutlineLibraryArrowLeft2,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text('Order', style: Theme.of(context).textTheme.titleLarge),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(height: 20.h),
          const DeliveryToggle(),
          SizedBox(height: 20.h),
          const SectionTitle(title: 'Delivery Address'),
          SizedBox(height: 16.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Jl. Kpg Sutoyo', style: theme.textTheme.titleMedium),
              SizedBox(height: 8.h),
              Text(
                'Kpg. Sutoyo No. 620, Bilzen, Tanjungbalai.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  ActionButton(
                    icon: Assets.icons.editSquare,
                    text: 'Edit Address',
                  ),
                  SizedBox(width: 12.w),
                  ActionButton(icon: Assets.icons.note, text: 'Add Note'),
                ],
              ),
            ],
          ),
          const Divider(height: 30, thickness: 1, color: AppColors.lightGrey),
          OrderItem(coffee: coffee),
          const Divider(height: 30, thickness: 1.5, color: AppColors.lightGrey),
          const DiscountSection(),
          SizedBox(height: 20.h),
          const SectionTitle(title: 'Payment Summary'),
          SizedBox(height: 16.h),
          Column(
            children: [
              _buildSummaryRow(
                'Price',
                '\$ ${coffee.price.toStringAsFixed(2)}',
              ),
              SizedBox(height: 16.h),
              _buildSummaryRow('Delivery Fee', '\$ 1.00'),
              const Divider(height: 30, thickness: 1),
              _buildSummaryRow(
                'Total Payment',
                '\$ ${(coffee.price + 1.0).toStringAsFixed(2)}',
                isTotal: true,
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 160.h,
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 16.h),
        color: AppColors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  Assets.icons.wallet,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Cash / Wallet', style: theme.textTheme.titleSmall),
                    SizedBox(width: 8.h),
                    Text(
                      '\$ ${(coffee.price + 1.0).toStringAsFixed(2)}',
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(width: 8.h),
                  ],
                ),

                const Spacer(),
                const Icon(Icons.keyboard_arrow_down),
              ],
            ),
            SizedBox(
              width: double.infinity,
              height: 55.h,
              child: ElevatedButton(
                onPressed: () {
                  context.push('/tracking');
                },
                child: const Text('Order'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String title, String amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            color: isTotal ? AppColors.darkGrey : Colors.grey.shade600,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: 14.sp,
            color: isTotal ? AppColors.darkGrey : Colors.grey.shade600,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
