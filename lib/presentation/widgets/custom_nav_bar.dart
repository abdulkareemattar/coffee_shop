import 'package:badges/badges.dart' as badges;
import 'package:coffee_shop/presentation/manager/cubit/favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:coffee_shop/core/utils/app_colors.dart';
import 'package:coffee_shop/gen/assets.gen.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    super.key,
    required this.isActivate,
    required this.pageController,
  });

  final int isActivate;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: [
        IconButton(
          onPressed: () => pageController.animateToPage(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          ),
          icon: SvgPicture.asset(
            Assets.icons.typeRegularStateOutlineLibraryHome,
            colorFilter: ColorFilter.mode(
              isActivate == 0 ? AppColors.primary : Colors.grey.shade400,
              BlendMode.srcIn,
            ),
          ),
        ),
        BlocBuilder<FavoritesCubit, FavoritesState>(
          builder: (context, state) {
            return badges.Badge(
              showBadge: state.favorites.isNotEmpty,
              badgeContent: Text(
                state.favorites.length.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
              position: badges.BadgePosition.topEnd(top: -12, end: -12),
              child: IconButton(
                onPressed: () => pageController.animateToPage(
                  1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                ),
                icon: SvgPicture.asset(
                  Assets.icons.typeRegularStateOutlineLibraryHeart,
                  colorFilter: ColorFilter.mode(
                    isActivate == 1 ? AppColors.primary : Colors.grey.shade400,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            );
          },
        ),

        IconButton(
          onPressed: () => pageController.animateToPage(
            2,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          ),
          icon: SvgPicture.asset(
            Assets.icons.typeRegularStateOutlineLibraryBag,
            colorFilter: ColorFilter.mode(
              isActivate == 2 ? AppColors.primary : Colors.grey.shade400,
              BlendMode.srcIn,
            ),
          ),
        ),

        IconButton(
          onPressed: () => pageController.animateToPage(
            3,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          ),
          icon: SvgPicture.asset(
            Assets.icons.typeRegularStateOutlineLibraryNotification,
            colorFilter: ColorFilter.mode(
              isActivate == 3 ? AppColors.primary : Colors.grey.shade400,
              BlendMode.srcIn,
            ),
          ),
        ),
      ],
    );
  }
}
