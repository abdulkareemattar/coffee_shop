import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:coffee_shop/core/utils/app_colors.dart';

class SelectSizeContainers extends StatefulWidget {
  const SelectSizeContainers({super.key});

  @override
  State<SelectSizeContainers> createState() => _SelectSizeContainersState();
}

class _SelectSizeContainersState extends State<SelectSizeContainers> {
  List<String> sizes = ["S", "M", "L"];
  int _selectedIndex = 1; // Default to M

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Size',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
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
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 6.w),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary.withOpacity(0.1)
                        : (isDark
                              ? Colors.white.withOpacity(0.05)
                              : Colors.white),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primary
                          : (isDark
                                ? Colors.white.withOpacity(0.1)
                                : Colors.grey.shade300),
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      sizes[index],
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: isSelected
                            ? AppColors.primary
                            : (isDark ? Colors.white70 : AppColors.darkGrey),
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
