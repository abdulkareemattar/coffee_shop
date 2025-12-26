import 'package:coffee_shop/presentation/common/dialogs/quantity_selection_dialog.dart';
import 'package:coffee_shop/domain/entities/cart_item.dart';
import 'package:coffee_shop/domain/entities/product.dart';
import 'package:coffee_shop/presentation/manager/cubit/cart/cart_cubit.dart';
import 'package:coffee_shop/presentation/manager/cubit/favorites_cubit.dart';
import 'package:coffee_shop/data/models/coffee_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import 'coffee_card.dart';

class CoffeeGrid extends StatelessWidget {
  const CoffeeGrid({super.key, required this.coffeeList});

  final List<CoffeeModel> coffeeList;

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
          itemCount: coffeeList.length,
          itemBuilder: (context, index) {
            final coffeeItem = coffeeList[index];
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
                    onAddTap: () => _addToCart(context, coffeeItem),
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

  void _addToCart(BuildContext context, CoffeeModel coffeeModel) async {
    final quantity = await showDialog<int>(
      context: context,
      builder: (context) => QuantitySelectionDialog(coffee: coffeeModel),
    );

    if (quantity == null || quantity <= 0) return;

    final product = Product(
      id: coffeeModel.id.toString(),
      name: coffeeModel.name,
      description: coffeeModel.description,
      price: coffeeModel.price,
      image: coffeeModel.imagePath,
      categoryId: coffeeModel.type,
      rating: coffeeModel.rating,
    );

    final cartItem = CartItem(
      id: const Uuid().v4(),
      product: product,
      quantity: quantity,
    );

    context.read<CartCubit>().addToCart(cartItem);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 20),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Success',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${coffeeModel.name} ($quantity) added to cart',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF323232),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        margin: EdgeInsets.all(20.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
