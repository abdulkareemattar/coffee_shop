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
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
        leading: Padding(
          padding: EdgeInsets.all(10.0.w),
          child: IconButton(
            icon: SvgPicture.asset(
              Assets.icons.typeRegularStateOutlineLibraryArrowLeft2,
              colorFilter: ColorFilter.mode(
                isDark ? Colors.white : Colors.black,
                BlendMode.srcIn,
              ),
            ),
            onPressed: () => context.pop(),
          ),
        ),
        title: Text(
          'Details',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: BlocBuilder<FavoritesCubit, FavoritesState>(
              builder: (context, state) {
                final isFavorite = state.favorites.any(
                  (fav) => fav.id == widget.coffeeModel.id,
                );
                return IconButton(
                  icon: SvgPicture.asset(
                    Assets.icons.typeRegularStateOutlineLibraryHeart,
                    colorFilter: ColorFilter.mode(
                      isFavorite
                          ? Colors.red
                          : (isDark ? Colors.white70 : Colors.black),
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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 202.h,
              width: double.infinity,
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
                const Spacer(),
                Row(
                  children: [
                    _buildInfoIcon(context, Assets.icons.icon.path),
                    SizedBox(width: 12.w),
                    _buildInfoIcon(context, Assets.icons.icon1.path),
                    SizedBox(width: 12.w),
                    _buildInfoIcon(context, Assets.icons.icon2.path),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12.h),
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
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Divider(
                color: isDark
                    ? Colors.white.withOpacity(0.05)
                    : Colors.grey.shade200,
                thickness: 1.h,
              ),
            ),
            Text('Description', style: theme.textTheme.titleLarge),
            SizedBox(height: 12.h),
            ReadMoreText(
              widget.coffeeModel.description,
              trimMode: TrimMode.Line,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isDark ? Colors.white70 : Colors.grey.shade600,
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
            SizedBox(height: 24.h),
            const SelectSizeContainers(),
            SizedBox(height: 120.h), // Space for bottom bar
          ],
        ),
      ),
      bottomNavigationBar: DetailsBottomBar(
        coffeeModel: widget.coffeeModel,
        onAddToCart: () => _addToCart(context, widget.coffeeModel),
      ),
    );
  }

  Widget _buildInfoIcon(BuildContext context, String iconPath) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withOpacity(0.05)
            : const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(14.r),
        border: isDark
            ? Border.all(color: Colors.white.withOpacity(0.05))
            : null,
      ),
      child: Image.asset(
        iconPath,
        height: 20.h,
        color: isDark ? AppColors.primary : null,
      ),
    );
  }
}

void _addToCart(BuildContext context, CoffeeModel coffeeModel) {
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
    quantity: 1,
  );

  context.read<CartCubit>().addToCart(cartItem);

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('${coffeeModel.name} added to cart'),
      backgroundColor: AppColors.green,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
        label: 'View Cart',
        textColor: Colors.white,
        onPressed: () => context.go('/cart'),
      ),
    ),
  );
}
