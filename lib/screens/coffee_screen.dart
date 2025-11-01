import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app/app_colors.dart';
import '../gen/assets.gen.dart';
import '../widgets/categoery_taps.dart';
import '../widgets/coffee_grid.dart';
import '../widgets/promo_card.dart';

class CoffeePage extends StatelessWidget {
  const CoffeePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        children: [
          Stack(
            clipBehavior: Clip.none,

            children: [
              Container(
                height: 280.h,
                width: double.infinity,
                color: AppColors.darkGrey,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0.w,
                    vertical: 60.h,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                          Icon(Icons.keyboard_arrow_down, color: Colors.white),
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
                                      colors: [
                                        Colors.grey[850]!,
                                        Colors.grey[800]!,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                ),

                                TextField(
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.transparent,
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: 'Search coffee',
                                    hintStyle: TextStyle(
                                      color: Colors.grey.shade500,
                                    ),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: SvgPicture.asset(
                                        colorFilter: ColorFilter.mode(
                                          Colors.white,
                                          BlendMode.srcIn,
                                        ),
                                        Assets
                                            .icons
                                            .typeRegularStateOutlineLibrarySearch,
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
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14.r),
                                ),
                              ),
                              child: SvgPicture.asset(
                                colorFilter: ColorFilter.mode(
                                  Colors.white,
                                  BlendMode.srcIn,
                                ),
                                Assets
                                    .icons
                                    .typeRegularStateOutlineLibraryFilter,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 220.h,
                left: 30.w,
                right: 30.w,
                child: PromoCard(),
              ),
            ],
          ),
          SizedBox(height: 100.h),

          const CategoryTabs(),
          SizedBox(height: 24.h),

          const CoffeeGrid(),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
