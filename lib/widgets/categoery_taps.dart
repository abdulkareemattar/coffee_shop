
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app/app_colors.dart';

class CategoryTabs extends StatefulWidget {
  const CategoryTabs();

  @override
  State<CategoryTabs> createState() => CategoryTabsState();
}

class CategoryTabsState extends State<CategoryTabs> {
  final List<String> categories = ['All Coffee', 'Machiatto', 'Latte', 'Americano', 'Robusta'];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        itemCount: categories.length,
        separatorBuilder: (context, index) => SizedBox(width: 5.w),
        itemBuilder: (context, index) {
          bool isSelected = _selectedIndex == index;
          return ChoiceChip(
            label: Text(categories[index]),
            selected: isSelected,
            onSelected: (selected) {
              if (selected) {
                setState(() {
                  _selectedIndex = index;
                });
              }
            },
            backgroundColor: Colors.transparent,
            selectedColor: AppColors.primary,
            labelStyle: TextStyle(
              color: isSelected ? Colors.white : AppColors.darkGrey,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
              side: const BorderSide(color: Colors.transparent),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
          );
        },
      ),
    );
  }
}
