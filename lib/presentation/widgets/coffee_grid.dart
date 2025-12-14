import 'package:coffee_shop/presentation/manager/cubit/favorites_cubit.dart';
import 'package:coffee_shop/gen/assets.gen.dart';
import 'package:coffee_shop/data/models/coffee_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'coffee_card.dart';

class CoffeeGrid extends StatelessWidget {
  const CoffeeGrid({super.key});

  static final List<CoffeeModel> _coffeeList = [
    CoffeeModel(
      id: 1,
      imagePath: Assets.images.property1CoffeeProperty21.path,
      name: 'Caffe Mocha',
      type: 'Deep Foam',
      price: 4.53,
      rating: 4.8,
      description: '...',
    ),
    CoffeeModel(
      id: 2,
      imagePath: Assets.images.property1CoffeeProperty22.path,
      name: 'Flat White',
      type: 'Espresso',
      price: 3.53,
      rating: 4.9,
      description: '...',
    ),
    CoffeeModel(
      id: 3,
      imagePath: Assets.images.property1CoffeeProperty23.path,
      name: 'Cappuccino',
      type: 'Steamed Milk',
      price: 4.20,
      rating: 4.7,
      description: '...',
    ),
    CoffeeModel(
      id: 4,
      imagePath: Assets.images.property1CoffeeProperty24.path,
      name: 'Americano',
      type: 'Hot Water',
      price: 3.10,
      rating: 4.6,
      description: '...',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15.w,
            mainAxisSpacing: 15.h,
            childAspectRatio: 0.72,
          ),
          itemCount: _coffeeList.length,
          itemBuilder: (context, index) {
            final coffeeItem = _coffeeList[index];
            final isFavorite = state.favorites.any(
              (fav) => fav.id == coffeeItem.id,
            );
            return InkWell(
              onTap: () {
                context.push('/details', extra: coffeeItem);
              },
              child: Stack(
                children: [
                  CoffeeCard(
                    imagePath: coffeeItem.imagePath,
                    name: coffeeItem.name,
                    type: coffeeItem.type,
                    price: coffeeItem.price,
                    rating: coffeeItem.rating,
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {
                        context.read<FavoritesCubit>().toggleFavorite(
                          coffeeItem,
                        );
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.black.withOpacity(0.4),
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
