import 'package:coffee_shop/presentation/manager/cubit/products/products_state.dart';
import 'package:coffee_shop/presentation/pages/coffee/widgets/coffee_grid_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coffee_shop/presentation/manager/cubit/products/products_cubit.dart';
import 'package:coffee_shop/presentation/manager/cubit/categories/categories_cubit.dart';

import 'widgets/category_tabs.dart';
import 'widgets/coffee_grid.dart';
import 'widgets/coffee_header.dart';
import 'widgets/promo_card.dart';

class CoffeePage extends StatelessWidget {
  const CoffeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.wait([
            context.read<ProductsCubit>().loadProducts(),
            context.read<CategoriesCubit>().loadCategories(),
          ]);
        },
        child: ListView(
          padding: EdgeInsets.zero,
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                const CoffeeHeader(),
                Positioned(
                  top: 220.h,
                  left: 30.w,
                  right: 30.w,
                  child: const PromoCard(),
                ),
              ],
            ),
            SizedBox(height: 100.h),
            const CategoryTabs(),
            SizedBox(height: 24.h),
            BlocBuilder<ProductsCubit, ProductsState>(
              builder: (context, state) {
                return state.maybeWhen(
                  loading: () => const CoffeeGridShimmer(),
                  loaded: (coffees) {
                    if (coffees.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.all(40.h),
                          child: Column(
                            children: [
                              Icon(
                                Icons.coffee_outlined,
                                size: 64.sp,
                                color: Colors.grey.shade300,
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                'No coffee found!',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return CoffeeGrid(coffeeList: coffees);
                  },
                  error: (message) => Center(
                    child: Padding(
                      padding: EdgeInsets.all(24.h),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.error_outline_rounded,
                            size: 48.sp,
                            color: Colors.red.shade300,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            message.contains('SocketException')
                                ? 'No Internet Connection'
                                : 'Something went wrong',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade800,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            message,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey.shade600,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 16.h),
                          ElevatedButton.icon(
                            onPressed: () {
                              context.read<ProductsCubit>().loadProducts();
                            },
                            icon: const Icon(Icons.refresh, size: 18),
                            label: const Text('Retry'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  orElse: () => const CoffeeGrid(coffeeList: []),
                );
              },
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
