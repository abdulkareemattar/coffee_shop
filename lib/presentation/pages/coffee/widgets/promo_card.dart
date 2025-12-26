import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:coffee_shop/gen/assets.gen.dart';

class PromoCard extends StatelessWidget {
  const PromoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Stack(
          children: [
            Assets.images.banner1.image(
              width: double.infinity,
              height: 140.h,
              fit: BoxFit.cover,
            ),
            Container(
              width: double.infinity,
              height: 140.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.1),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 15.h,
              left: 24.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFED5151),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      'Promo',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  _buildPromoText('Buy one get'),
                  _buildPromoText('one FREE'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromoText(String text) {
    return Stack(
      children: [
        // Subtle background for text readability
        Text(
          text,
          style: TextStyle(
            color: Colors.black.withOpacity(0.5),
            fontFamily: 'Sora',
            fontSize: 32.sp,
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Sora',
            fontSize: 32.sp,
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
        ),
      ],
    );
  }
}
