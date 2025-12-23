import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:coffee_shop/core/utils/app_colors.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool showLogo;
  final bool isDark;

  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.showLogo = true,
    this.isDark = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = isDark ? Colors.white : Colors.black;
    final subtitleColor = isDark
        ? Colors.white.withOpacity(0.7)
        : Colors.grey.shade600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLogo) ...[
          SizedBox(height: 10.h),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: isDark ? Colors.white.withOpacity(0.1) : Colors.white,
                  shape: BoxShape.circle,
                  border: isDark
                      ? Border.all(color: Colors.white.withOpacity(0.2))
                      : null,
                  boxShadow: isDark
                      ? []
                      : [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 20,
                            offset: const Offset(0, 5),
                          ),
                        ],
                ),
                child: Image.asset(
                  'assets/icons/app_icon.png',
                  height: 35.h,
                  width: 35.h,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                'Kaffein',
                style: TextStyle(
                  color: isDark ? Colors.white : AppColors.primary,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Sora',
                ),
              ),
            ],
          ),
          SizedBox(height: 32.h),
        ],
        Text(
          title,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: textColor,
            fontFamily: 'Sora',
            fontSize: 26.sp,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          subtitle,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: subtitleColor,
            fontFamily: 'Sora',
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }
}
