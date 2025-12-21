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
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        return state.maybeWhen(
          loaded: (categories) {
            // Add "All" as first category
            final allCategories = [
              {'id': null, 'name': 'All Coffee'},
              ...categories.map((c) => {'id': c.id, 'name': c.name}),
            ];

            return SizedBox(
              height: 38.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                itemCount: allCategories.length,
                separatorBuilder: (context, index) => SizedBox(width: 5.w),
                itemBuilder: (context, index) {
                  final category = allCategories[index];
                  final categoryId = category['id'] as String?;
                  final categoryName = category['name'] as String;
                  bool isSelected = _selectedCategoryId == categoryId;

                  return ChoiceChip(
                    label: Text(categoryName),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          _selectedCategoryId = categoryId;
                        });
                        // Load products by category or all products
                        if (categoryId == null) {
                          context.read<ProductsCubit>().loadProducts();
                        } else {
                          context.read<ProductsCubit>().loadProductsByCategory(
                            categoryId,
                          );
                        }
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
          },
          loading: () => SizedBox(
            height: 38.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              itemCount: 5,
              separatorBuilder: (context, index) => SizedBox(width: 5.w),
              itemBuilder: (context, index) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 80.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ),
          ),
          error: (message) => SizedBox(
            height: 38.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Failed to load categories',
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                ),
                TextButton(
                  onPressed: () =>
                      context.read<CategoriesCubit>().loadCategories(),
                  child: Text('Retry', style: TextStyle(fontSize: 12.sp)),
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
