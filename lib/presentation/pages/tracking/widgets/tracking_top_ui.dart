import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:coffee_shop/core/utils/app_colors.dart';
import 'package:coffee_shop/gen/assets.gen.dart';
import 'package:go_router/go_router.dart';

class TrackingTopUI extends StatelessWidget {
  const TrackingTopUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50.h,
      left: 20.w,
      right: 20.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCircleButton(
            icon: Assets.icons.typeRegularStateOutlineLibraryArrowLeft2,
            onTap: () => context.pop(),
          ),
          _buildCircleButton(icon: Assets.icons.gps, onTap: () {}),
        ],
      ),
    );
  }

  Widget _buildCircleButton({
    required String icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: const BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: SvgPicture.asset(icon, height: 24.h),
      ),
    );
  }
}
