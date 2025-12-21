import 'package:coffee_shop/core/utils/app_colors.dart';
import 'package:coffee_shop/data/models/coffee_model.dart';
import 'package:coffee_shop/domain/entities/cart_item.dart';
import 'package:coffee_shop/domain/entities/product.dart';
import 'package:coffee_shop/presentation/manager/cubit/cart/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coffee_shop/presentation/manager/cubit/favorites_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../coffee/widgets/coffee_card.dart';
import '../../common/dialogs/quantity_selection_dialog.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Favorites',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          if (state.favorites.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 64.sp,
                    color: Colors.grey.shade300,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Your favorites list is empty.',
                    style: TextStyle(fontSize: 18.sp, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
            itemCount: state.favorites.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15.w,
              mainAxisSpacing: 15.h,
              childAspectRatio: 0.72,
            ),
            itemBuilder: (context, index) {
              final coffeeItem = state.favorites[index];
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
                      onAddTap: () =>
                          _addToCart(context, coffeeItem as CoffeeModel),
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
                          child: const Icon(
                            Icons.favorite,
                            color: Colors.red,
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
      ),
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
        content: Text('${coffeeModel.name} ($quantity) added to cart'),
        backgroundColor: AppColors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
