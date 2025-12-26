import 'dart:ui';
import 'package:badges/badges.dart' as badges;
import 'package:coffee_shop/presentation/manager/cubit/favorites_cubit.dart';
import 'package:coffee_shop/presentation/manager/cubit/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:coffee_shop/core/utils/app_colors.dart';
import 'package:coffee_shop/gen/assets.gen.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    super.key,
    required this.isActivate,
    required this.pageController,
  });

  final int isActivate;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          height: 85.h,
          decoration: BoxDecoration(
            color: isDark
                ? const Color(0xFF131313).withOpacity(0.8)
                : Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
            border: Border(
              top: BorderSide(
                color: isDark
                    ? Colors.white.withOpacity(0.05)
                    : Colors.black.withOpacity(0.05),
                width: 1.5,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(
                    context,
                    index: 0,
                    icon: Assets.icons.typeRegularStateOutlineLibraryHome,
                    onTap: () => pageController.animateToPage(
                      0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    ),
                  ),
                  BlocBuilder<FavoritesCubit, FavoritesState>(
                    builder: (context, state) {
                      return badges.Badge(
                        showBadge: state.favorites.isNotEmpty,
                        badgeContent: Text(
                          state.favorites.length.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        position: badges.BadgePosition.topEnd(top: -8, end: -8),
                        badgeStyle: badges.BadgeStyle(
                          badgeColor: AppColors.primary,
                          padding: EdgeInsets.all(4.w),
                        ),
                        child: _buildNavItem(
                          context,
                          index: 1,
                          icon:
                              Assets.icons.typeRegularStateOutlineLibraryHeart,
                          onTap: () => pageController.animateToPage(
                            1,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          ),
                        ),
                      );
                    },
                  ),
                  _buildNavItem(
                    context,
                    index: 2,
                    icon: Assets.icons.typeRegularStateOutlineLibraryBag,
                    onTap: () => pageController.animateToPage(
                      2,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    ),
                  ),
                  _buildNavItem(
                    context,
                    index: 3,
                    icon:
                        Assets.icons.typeRegularStateOutlineLibraryNotification,
                    onTap: () => pageController.animateToPage(
                      3,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required int index,
    required String icon,
    required VoidCallback onTap,
  }) {
    final isActive = isActivate == index;
    final isDark = context.isDarkMode;

    return InkWell(
      onTap: onTap,
      splashColor: AppColors.primary.withOpacity(0.1),
      highlightColor: Colors.transparent,
      borderRadius: BorderRadius.circular(12.r),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.primary.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              icon,
              width: 24.w,
              height: 24.h,
              colorFilter: ColorFilter.mode(
                isActive
                    ? AppColors.primary
                    : (isDark
                          ? Colors.white.withOpacity(0.5)
                          : Colors.grey.shade400),
                BlendMode.srcIn,
              ),
            ),
            if (isActive) ...[
              SizedBox(height: 4.h),
              Container(
                width: 4.w,
                height: 4.h,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
