import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app/app_colors.dart';

class SelectSizeContainers extends StatefulWidget {
  const SelectSizeContainers({super.key});

  @override
  State<SelectSizeContainers> createState() => _SelectSizeContainersState();
}

class _SelectSizeContainersState extends State<SelectSizeContainers> {
  List<String> sizes =["S","M","L"];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Size', style: Theme.of(context).textTheme.titleLarge),
        SizedBox(height: 12.h),
        Row(
          children: List.generate(sizes.length, (index) {
            bool isSelected = _selectedIndex == index;
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 6.w),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary.withOpacity(0.15)
                        : AppColors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primary
                          : Colors.grey.shade300,
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      sizes[index],
                      style: Theme.of(context).textTheme.bodyLarge
                          ?.copyWith(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.darkGrey,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
