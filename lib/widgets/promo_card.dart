import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../gen/assets.gen.dart';

class PromoCard extends StatelessWidget {
  const PromoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
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
            color: Colors.black.withOpacity(0.15),
          ),
          Positioned(
            top: 15.h,
            left: 24.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.red,
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
                SizedBox(height: 8.h),

                const TextWithBackground(
                  text: 'Buy one get',
                  style: TextStyle(
                    color: Colors.transparent,
                    fontFamily: 'Sora',
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    height: 1.1,
                  ),
                ),
                const TextWithBackground(
                  text: 'one FREE',
                  style: TextStyle(
                    fontFamily: 'Sora',
                    color: Colors.transparent,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    height: 1.1,
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
class TextWithBackground extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Color backgroundColor;

  const TextWithBackground({
    super.key,
    required this.text,
    required this.style,
    this.backgroundColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center,
      children: [
        Padding(
          padding:  EdgeInsets.only(top: 20.h),
          child: Container(height: 20.h,
            color: backgroundColor,
            child: Text(text, style: style,),
          ),
        ),
        Text(text, style: TextStyle(
          color: Colors.white,
          fontFamily: 'Sora',
          fontSize: 32,
          fontWeight: FontWeight.bold,
          height: 1.1,
        ),),
      ],
    );
  }
}
