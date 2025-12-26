import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coffee_shop/core/utils/app_colors.dart';
import 'package:coffee_shop/presentation/manager/cubit/categories/categories_cubit.dart';
import 'package:coffee_shop/presentation/manager/cubit/categories/categories_state.dart';
import 'package:coffee_shop/presentation/manager/cubit/products/products_cubit.dart';

class CategoryTabs extends StatefulWidget {
  const CategoryTabs({super.key});

  @override
  State<CategoryTabs> createState() => CategoryTabsState();
}

class CategoryTabsState extends State<CategoryTabs> {
  String? _selectedCategoryId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        return state.maybeWhen(
          loaded: (categories) {
            final allCategories = [
              {'id': null, 'name': 'All Coffee'},
              ...categories.map((c) => {'id': c.id, 'name': c.name}),
            ];

            return SizedBox(
              height: 42.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                itemCount: allCategories.length,
                separatorBuilder: (context, index) => SizedBox(width: 8.w),
                itemBuilder: (context, index) {
                  final category = allCategories[index];
                  final categoryId = category['id'] as String?;
                  final categoryName = category['name'] as String;
                  bool isSelected = _selectedCategoryId == categoryId;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategoryId = categoryId;
                      });
                      if (categoryId == null) {
                        context.read<ProductsCubit>().loadProducts();
                      } else {
                        context.read<ProductsCubit>().loadProductsByCategory(
                          categoryId,
                        );
                      }
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary
                            : (isDark
                                  ? Colors.white.withOpacity(0.05)
                                  : const Color(0xFFF9F9F9)),
                        borderRadius: BorderRadius.circular(12.r),
                        border: isSelected
                            ? null
                            : Border.all(
                                color: isDark
                                    ? Colors.white.withOpacity(0.1)
                                    : Colors.transparent,
                              ),
                      ),
                      child: Text(
                        categoryName,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: isSelected
                              ? Colors.white
                              : (isDark ? Colors.white70 : AppColors.darkGrey),
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
          loading: () => SizedBox(
            height: 42.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              itemCount: 5,
              separatorBuilder: (context, index) => SizedBox(width: 8.w),
              itemBuilder: (context, index) => Shimmer.fromColors(
                baseColor: isDark ? Colors.grey[900]! : Colors.grey[300]!,
                highlightColor: isDark ? Colors.grey[800]! : Colors.grey[100]!,
                child: Container(
                  width: 90.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ),
          ),
          error: (message) => SizedBox(
            height: 42.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Failed to load categories',
                  style: theme.textTheme.bodySmall,
                ),
                TextButton(
                  onPressed: () =>
                      context.read<CategoriesCubit>().loadCategories(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}
