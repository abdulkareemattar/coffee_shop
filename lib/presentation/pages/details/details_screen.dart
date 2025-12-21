import 'package:coffee_shop/core/utils/app_colors.dart';
import 'package:coffee_shop/data/models/coffee_model.dart';
import 'package:coffee_shop/gen/assets.gen.dart';
import 'package:coffee_shop/presentation/manager/cubit/favorites_cubit.dart';
import 'package:coffee_shop/presentation/manager/cubit/cart/cart_cubit.dart';
import 'package:coffee_shop/domain/entities/cart_item.dart';
import 'package:coffee_shop/domain/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:readmore/readmore.dart';
import 'package:uuid/uuid.dart';
import 'package:coffee_shop/core/widgets/custom_network_image.dart';

import 'widgets/details_bottom_bar.dart';
import 'widgets/select_size_containers.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.coffeeModel});

  final CoffeeModel coffeeModel;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
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
            onPressed: () => context.pop(),
          ),
        ),
        title: Text('Details of ${widget.coffeeModel.name}'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<FavoritesCubit, FavoritesState>(
              builder: (context, state) {
                final isFavorite = state.favorites.any(
                  (fav) => fav.id == widget.coffeeModel.id,
                );
                return IconButton(
                  iconSize: 32,
                  icon: SvgPicture.asset(
                    Assets.icons.typeRegularStateOutlineLibraryHeart,
                    colorFilter: ColorFilter.mode(
                      isFavorite ? Colors.red : Colors.grey,
                      BlendMode.srcIn,
                    ),
                  ),
                  onPressed: () {
                    context.read<FavoritesCubit>().toggleFavorite(
                      widget.coffeeModel,
                    );
                  },
                );
              },
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
                child: CustomNetworkImage(
                  imageUrl: widget.coffeeModel.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              widget.coffeeModel.name,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontFamily: Assets.fonts.soraExtraBold,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2.h),
            Row(
              children: [
                Text(
                  widget.coffeeModel.type,
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
                      widget.coffeeModel.rating.toString(),
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
                  widget.coffeeModel.description,
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
      bottomNavigationBar: DetailsBottomBar(
        coffeeModel: widget.coffeeModel,
        onAddToCart: () => _addToCart(context, widget.coffeeModel),
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

void _addToCart(BuildContext context, CoffeeModel coffeeModel) {
  // Convert CoffeeModel to Product
  final product = Product(
    id: coffeeModel.id.toString(),
    name: coffeeModel.name,
    description: coffeeModel.description,
    price: coffeeModel.price,
    image: coffeeModel.imagePath,
    categoryId: coffeeModel.type,
    rating: coffeeModel.rating,
  );

  // Create CartItem
  final cartItem = CartItem(
    id: const Uuid().v4(),
    product: product,
    quantity: 1,
  );

  // Add to cart
  context.read<CartCubit>().addToCart(cartItem);

  // Show success message
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('${coffeeModel.name} added to cart'),
      backgroundColor: AppColors.green,
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
        label: 'View Cart',
        textColor: Colors.white,
        onPressed: () {
          context.go('/cart');
        },
      ),
    ),
  );
}
