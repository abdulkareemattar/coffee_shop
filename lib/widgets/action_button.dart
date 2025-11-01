import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../app/app_colors.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({super.key,required this.icon, required this.text});
final String icon;
final String text;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: SvgPicture.asset(icon, height: 20.h, colorFilter: const ColorFilter.mode(AppColors.darkGrey, BlendMode.srcIn)),
      label: Text(text),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.darkGrey,
        side: const BorderSide(color: AppColors.lightGrey),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      ),
    );
  }
}
