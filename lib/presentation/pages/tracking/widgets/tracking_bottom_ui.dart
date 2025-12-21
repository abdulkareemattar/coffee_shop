import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:coffee_shop/core/utils/app_colors.dart';
import 'package:coffee_shop/gen/assets.gen.dart';

class TrackingBottomUI extends StatelessWidget {
  const TrackingBottomUI({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 50.w,
                height: 5.h,
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text('10 minutes left', style: theme.textTheme.titleMedium),
            SizedBox(height: 4.h),
            Row(
              children: [
                Text(
                  'Delivery to ',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
                Text(
                  'Jl. Kpg Sutoyo',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            LinearProgressIndicator(
              value: 0.75,
              backgroundColor: AppColors.lightGrey,
              color: const Color(0xFF36C07E),
              minHeight: 4.h,
              borderRadius: BorderRadius.circular(100),
            ),
            SizedBox(height: 20.h),
            _buildStatusCard(theme),
            SizedBox(height: 12.h),
            _buildCourierCard(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(ThemeData theme) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.lightGrey),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: AppColors.lightBrown,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: SvgPicture.asset(Assets.icons.icon.path, height: 24.h),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Delivered your order',
                  style: theme.textTheme.titleMedium,
                ),
                SizedBox(height: 4.h),
                Text(
                  'We will deliver your goods to you in the shortest possible time.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourierCard(ThemeData theme) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(14.r),
          child: Image.asset(
            Assets.images.image.path,
            width: 54.w,
            height: 54.h,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Brooklyn Simmons', style: theme.textTheme.titleMedium),
            SizedBox(height: 4.h),
            Text(
              'Personal Courier',
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
        const Spacer(),
        Container(
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.lightGrey),
          ),
          child: SvgPicture.asset(
            Assets.icons.typeRegularStateOutlineLibraryCalling,
            height: 24.h,
          ),
        ),
      ],
    );
  }
}
