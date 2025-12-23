import 'package:coffee_shop/presentation/manager/cubit/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coffee_shop/core/utils/app_colors.dart';
import 'package:coffee_shop/gen/assets.gen.dart';
import 'package:coffee_shop/presentation/manager/cubit/products/products_cubit.dart';
import 'filter_bottom_sheet.dart';

class CoffeeHeader extends StatefulWidget {
  const CoffeeHeader({super.key});

  @override
  State<CoffeeHeader> createState() => _CoffeeHeaderState();
}

class _CoffeeHeaderState extends State<CoffeeHeader> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (query.isEmpty) {
      context.read<ProductsCubit>().loadProducts();
    } else {
      context.read<ProductsCubit>().searchProducts(query);
    }
  }

  void _showFilterBottomSheet() async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const FilterBottomSheet(),
    );

    if (result != null && mounted) {
      final RangeValues priceRange = result['priceRange'];
      final double minRating = result['minRating'];

      context.read<ProductsCubit>().applyFilters(
        minPrice: priceRange.start,
        maxPrice: priceRange.end,
        minRating: minRating,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      height: 280.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF131313) : AppColors.darkGrey,
        gradient: isDark
            ? const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF131313), Color(0xFF202020)],
              )
            : null,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.0.w, vertical: 60.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Location',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Bilzen, Tanjungbalai',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontFamily: Assets.fonts.soraBold,
                            color: Colors.white,
                          ),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
                // Theme Toggle Button
                IconButton(
                  onPressed: () => context.read<ThemeCubit>().toggleTheme(),
                  icon: Icon(
                    isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                    color: Colors.white,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 52.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          gradient: LinearGradient(
                            colors: [Colors.grey[850]!, Colors.grey[800]!],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                      TextField(
                        controller: _searchController,
                        onChanged: _onSearchChanged,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.transparent,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: 'Search coffee',
                          hintStyle: TextStyle(color: Colors.grey.shade500),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SvgPicture.asset(
                              colorFilter: const ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                              Assets.icons.typeRegularStateOutlineLibrarySearch,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: _showFilterBottomSheet,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      minimumSize: Size(52.w, 52.h),
                    ),
                    child: SvgPicture.asset(
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                      Assets.icons.typeRegularStateOutlineLibraryFilter,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
