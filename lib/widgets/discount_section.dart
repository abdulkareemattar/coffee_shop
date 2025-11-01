import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../app/app_colors.dart';
import '../gen/assets.gen.dart';

class DiscountSection extends StatelessWidget {
  const DiscountSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.lightGrey),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            Assets.icons.typeRegularStateOutlineLibraryDiscount,
            colorFilter: const ColorFilter.mode(
              AppColors.primary,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            '1 Discount is Applied',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios,
            size: 18,
            color: AppColors.darkGrey,
          ),
        ],
      ),
    );
  }
}
