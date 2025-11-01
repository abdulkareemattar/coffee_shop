import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../app/app_colors.dart';
import '../gen/assets.gen.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key, required this.isActivate, required this.pageController});

  final int isActivate;
  final PageController pageController;

@override
  Widget build (BuildContext context) {
    return NavigationBar(
      destinations: [
        IconButton(
          onPressed:(){pageController.animateToPage(0, duration: const Duration(milliseconds: 300), curve: Curves.ease);},
          icon: SvgPicture.asset(
            colorFilter: ColorFilter.mode(
              isActivate == 0 ? AppColors.primary : Colors.grey.shade400,
              BlendMode.srcIn,
            ),
           Assets.icons.typeRegularStateOutlineLibraryHome,
          ),
        ),
        IconButton(
          onPressed:(){pageController.animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.ease);},
          icon: SvgPicture.asset(
            colorFilter: ColorFilter.mode(
              isActivate == 1 ? AppColors.primary : Colors.grey.shade400,
              BlendMode.srcIn,
            ),
           Assets.icons.typeRegularStateOutlineLibraryHeart,
          ),
        ),
        IconButton(
          onPressed:(){pageController.animateToPage(2, duration: const Duration(milliseconds: 300), curve: Curves.ease);},
          icon: SvgPicture.asset(
            colorFilter: ColorFilter.mode(
              isActivate == 2 ? AppColors.primary : Colors.grey.shade400,
              BlendMode.srcIn,
            ),
           Assets.icons.typeRegularStateOutlineLibraryBag,
          ),
        ),
        IconButton(
          onPressed:(){pageController.animateToPage(3, duration: const Duration(milliseconds: 300), curve: Curves.ease);},
          icon: SvgPicture.asset(
            colorFilter: ColorFilter.mode(
              isActivate == 3 ? AppColors.primary : Colors.grey.shade400,
              BlendMode.srcIn,
            ),
           Assets.icons.typeRegularStateOutlineLibraryNotification,
          ),
        ),

      ],
    );
  }}