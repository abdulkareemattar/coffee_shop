import 'package:coffee_shop/models/coffee_model.dart';
import 'package:coffee_shop/screens/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:readmore/readmore.dart';

import '../app/app_colors.dart';
import '../gen/assets.gen.dart';
import '../widgets/select_size_containers.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.coffeeModel});

  final CoffeeModel coffeeModel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(10.0.w),
          child: IconButton(
            icon: SvgPicture.asset(
              Assets.icons.typeRegularStateOutlineLibraryArrowLeft2,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        title: Text('Details of ${coffeeModel.name}'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SvgPicture.asset(
              Assets.icons.typeRegularStateOutlineLibraryHeart,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        child: ListView(
          children: [
            SizedBox(
              height: 202.h,
              width: 327.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Image.asset(coffeeModel.imagePath, fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              coffeeModel.name,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontFamily: Assets.fonts.soraExtraBold,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2.h),
            Row(
              children: [
                Text(
                  coffeeModel.type,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade500,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    _buildInfoIcon(Assets.icons.icon.path),
                    SizedBox(width: 12.w),
                    _buildInfoIcon(Assets.icons.icon1.path),
                    SizedBox(width: 12.w),
                    _buildInfoIcon(Assets.icons.icon2.path),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 24),
                    SizedBox(width: 4.w),
                    Text(
                      coffeeModel.rating.toString(),
                      style: theme.textTheme.titleMedium,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '(230)',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Divider(color: Colors.grey.shade300, thickness: 1.h),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Description', style: theme.textTheme.titleLarge),
                SizedBox(height: 12.h),
                ReadMoreText(
                  coffeeModel.description,
                  trimMode: TrimMode.Line,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade600,
                    height: 1.5,
                  ),

                  trimCollapsedText: ' Read More',
                  moreStyle: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),

                  trimExpandedText: ' Read Less',
                  lessStyle: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            SelectSizeContainers(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 118.h,
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, -10),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Price',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade500,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '\$ ${coffeeModel.price.toStringAsFixed(2)}',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 217.w,
              height: 56.h,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderScreen(coffee: coffeeModel),
                    ),
                  );
                },
                child: const Text('Buy Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildInfoIcon(String iconPath) {
  return Container(
    padding: EdgeInsets.all(12.r),
    decoration: BoxDecoration(
      color: AppColors.lightGrey.withAlpha(50),
      borderRadius: BorderRadius.circular(14.r),
    ),
    child: Image.asset(iconPath, height: 20.h),
  );
}
