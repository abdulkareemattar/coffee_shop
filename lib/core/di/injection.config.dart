// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/datasources/remote/auth_api_client.dart' as _i972;
import '../../data/datasources/remote/category_api_client.dart' as _i300;
import '../../data/datasources/remote/product_api_client.dart' as _i9;
import '../../data/repositories/auth_repository.dart' as _i481;
import '../../data/repositories/auth_repository_impl.dart' as _i895;
import '../../data/repositories/cart_repository_impl.dart' as _i915;
import '../../data/repositories/category_repository_impl.dart' as _i538;
import '../../data/repositories/coffee_repository_impl.dart' as _i1032;
import '../../data/repositories/order_repository_impl.dart' as _i717;
import '../../data/repositories/product_repository_impl.dart' as _i876;
import '../../domain/repositories/auth_repository.dart' as _i1073;
import '../../domain/repositories/cart_repository.dart' as _i46;
import '../../domain/repositories/category_repository.dart' as _i485;
import '../../domain/repositories/coffee_repository.dart' as _i812;
import '../../domain/repositories/order_repository.dart' as _i507;
import '../../domain/repositories/product_repository.dart' as _i933;
import '../../domain/usecases/add_to_cart_usecase.dart' as _i612;
import '../../domain/usecases/cancel_order_usecase.dart' as _i218;
import '../../domain/usecases/check_auth_status_usecase.dart' as _i959;
import '../../domain/usecases/clear_cart_usecase.dart' as _i44;
import '../../domain/usecases/create_order_usecase.dart' as _i1052;
import '../../domain/usecases/get_cart_items_usecase.dart' as _i237;
import '../../domain/usecases/get_cart_total_usecase.dart' as _i303;
import '../../domain/usecases/get_categories_usecase.dart' as _i943;
import '../../domain/usecases/get_category_by_id_usecase.dart' as _i626;
import '../../domain/usecases/get_favorites_usecase.dart' as _i520;
import '../../domain/usecases/get_order_by_id_usecase.dart' as _i141;
import '../../domain/usecases/get_product_by_id_usecase.dart' as _i705;
import '../../domain/usecases/get_products_by_category_usecase.dart' as _i279;
import '../../domain/usecases/get_products_usecase.dart' as _i626;
import '../../domain/usecases/get_user_orders_usecase.dart' as _i1064;
import '../../domain/usecases/login_usecase.dart' as _i253;
import '../../domain/usecases/logout_usecase.dart' as _i981;
import '../../domain/usecases/register_usecase.dart' as _i35;
import '../../domain/usecases/remove_from_cart_usecase.dart' as _i356;
import '../../domain/usecases/search_products_usecase.dart' as _i473;
import '../../domain/usecases/toggle_favorite_usecase.dart' as _i308;
import '../../domain/usecases/update_cart_item_quantity_usecase.dart' as _i188;
import '../../domain/usecases/update_order_status_usecase.dart' as _i206;
import '../../presentation/manager/cubit/auth/auth_cubit.dart' as _i748;
import '../../presentation/manager/cubit/cart/cart_cubit.dart' as _i772;
import '../../presentation/manager/cubit/categories/categories_cubit.dart'
    as _i1026;
import '../../presentation/manager/cubit/favorites_cubit.dart' as _i288;
import '../../presentation/manager/cubit/orders/orders_cubit.dart' as _i869;
import '../../presentation/manager/cubit/products/products_cubit.dart' as _i719;
import '../network/api_client_module.dart' as _i651;
import '../network/dio_module.dart' as _i614;
import '../router/app_router.dart' as _i81;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final networkModule = _$NetworkModule();
    final apiClientModule = _$ApiClientModule();
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => networkModule.secureStorage,
    );
    gh.lazySingleton<_i81.AppRouter>(() => _i81.AppRouter());
    gh.lazySingleton<_i46.CartRepository>(() => _i915.CartRepositoryImpl());
    gh.lazySingleton<_i507.OrderRepository>(() => _i717.OrderRepositoryImpl());
    gh.lazySingleton<_i361.Dio>(
      () => networkModule.provideDio(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i612.AddToCartUseCase>(
      () => _i612.AddToCartUseCase(gh<_i46.CartRepository>()),
    );
    gh.lazySingleton<_i44.ClearCartUseCase>(
      () => _i44.ClearCartUseCase(gh<_i46.CartRepository>()),
    );
    gh.lazySingleton<_i237.GetCartItemsUseCase>(
      () => _i237.GetCartItemsUseCase(gh<_i46.CartRepository>()),
    );
    gh.lazySingleton<_i303.GetCartTotalUseCase>(
      () => _i303.GetCartTotalUseCase(gh<_i46.CartRepository>()),
    );
    gh.lazySingleton<_i356.RemoveFromCartUseCase>(
      () => _i356.RemoveFromCartUseCase(gh<_i46.CartRepository>()),
    );
    gh.lazySingleton<_i188.UpdateCartItemQuantityUseCase>(
      () => _i188.UpdateCartItemQuantityUseCase(gh<_i46.CartRepository>()),
    );
    gh.factory<_i772.CartCubit>(
      () => _i772.CartCubit(
        gh<_i237.GetCartItemsUseCase>(),
        gh<_i612.AddToCartUseCase>(),
        gh<_i356.RemoveFromCartUseCase>(),
        gh<_i188.UpdateCartItemQuantityUseCase>(),
        gh<_i44.ClearCartUseCase>(),
        gh<_i303.GetCartTotalUseCase>(),
      ),
    );
    gh.lazySingleton<_i218.CancelOrderUseCase>(
      () => _i218.CancelOrderUseCase(gh<_i507.OrderRepository>()),
    );
    gh.lazySingleton<_i1052.CreateOrderUseCase>(
      () => _i1052.CreateOrderUseCase(gh<_i507.OrderRepository>()),
    );
    gh.lazySingleton<_i141.GetOrderByIdUseCase>(
      () => _i141.GetOrderByIdUseCase(gh<_i507.OrderRepository>()),
    );
    gh.lazySingleton<_i1064.GetUserOrdersUseCase>(
      () => _i1064.GetUserOrdersUseCase(gh<_i507.OrderRepository>()),
    );
    gh.lazySingleton<_i206.UpdateOrderStatusUseCase>(
      () => _i206.UpdateOrderStatusUseCase(gh<_i507.OrderRepository>()),
    );
    gh.factory<_i869.OrdersCubit>(
      () => _i869.OrdersCubit(
        gh<_i1052.CreateOrderUseCase>(),
        gh<_i1064.GetUserOrdersUseCase>(),
        gh<_i206.UpdateOrderStatusUseCase>(),
        gh<_i218.CancelOrderUseCase>(),
      ),
    );
    gh.lazySingleton<_i972.AuthApiClient>(
      () => apiClientModule.provideAuthApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i9.ProductApiClient>(
      () => apiClientModule.provideProductApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i300.CategoryApiClient>(
      () => apiClientModule.provideCategoryApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i933.ProductRepository>(
      () => _i876.ProductRepositoryImpl(gh<_i9.ProductApiClient>()),
    );
    gh.lazySingleton<_i812.CoffeeRepository>(
      () => _i1032.CoffeeRepositoryImpl(gh<_i9.ProductApiClient>()),
    );
    gh.lazySingleton<_i481.AuthRepository>(
      () => _i481.AuthRepository(
        gh<_i972.AuthApiClient>(),
        gh<_i558.FlutterSecureStorage>(),
      ),
    );
    gh.lazySingleton<_i1073.AuthRepository>(
      () => _i895.AuthRepositoryImpl(
        gh<_i972.AuthApiClient>(),
        gh<_i558.FlutterSecureStorage>(),
      ),
    );
    gh.lazySingleton<_i485.CategoryRepository>(
      () => _i538.CategoryRepositoryImpl(gh<_i300.CategoryApiClient>()),
    );
    gh.lazySingleton<_i279.GetProductsByCategoryUseCase>(
      () => _i279.GetProductsByCategoryUseCase(gh<_i933.ProductRepository>()),
    );
    gh.lazySingleton<_i626.GetProductsUseCase>(
      () => _i626.GetProductsUseCase(gh<_i933.ProductRepository>()),
    );
    gh.lazySingleton<_i705.GetProductByIdUseCase>(
      () => _i705.GetProductByIdUseCase(gh<_i933.ProductRepository>()),
    );
    gh.lazySingleton<_i473.SearchProductsUseCase>(
      () => _i473.SearchProductsUseCase(gh<_i933.ProductRepository>()),
    );
    gh.factory<_i719.ProductsCubit>(
      () => _i719.ProductsCubit(
        gh<_i626.GetProductsUseCase>(),
        gh<_i279.GetProductsByCategoryUseCase>(),
        gh<_i473.SearchProductsUseCase>(),
      ),
    );
    gh.lazySingleton<_i520.GetFavoritesUseCase>(
      () => _i520.GetFavoritesUseCase(gh<_i812.CoffeeRepository>()),
    );
    gh.lazySingleton<_i308.ToggleFavoriteUseCase>(
      () => _i308.ToggleFavoriteUseCase(gh<_i812.CoffeeRepository>()),
    );
    gh.lazySingleton<_i959.CheckAuthStatusUseCase>(
      () => _i959.CheckAuthStatusUseCase(gh<_i1073.AuthRepository>()),
    );
    gh.lazySingleton<_i253.LoginUseCase>(
      () => _i253.LoginUseCase(gh<_i1073.AuthRepository>()),
    );
    gh.lazySingleton<_i981.LogoutUseCase>(
      () => _i981.LogoutUseCase(gh<_i1073.AuthRepository>()),
    );
    gh.lazySingleton<_i35.RegisterUseCase>(
      () => _i35.RegisterUseCase(gh<_i1073.AuthRepository>()),
    );
    gh.lazySingleton<_i943.GetCategoriesUseCase>(
      () => _i943.GetCategoriesUseCase(gh<_i485.CategoryRepository>()),
    );
    gh.lazySingleton<_i626.GetCategoryByIdUseCase>(
      () => _i626.GetCategoryByIdUseCase(gh<_i485.CategoryRepository>()),
    );
    gh.factory<_i1026.CategoriesCubit>(
      () => _i1026.CategoriesCubit(
        gh<_i943.GetCategoriesUseCase>(),
        gh<_i626.GetCategoryByIdUseCase>(),
      ),
    );
    gh.factory<_i288.FavoritesCubit>(
      () => _i288.FavoritesCubit(
        getFavoritesUseCase: gh<_i520.GetFavoritesUseCase>(),
        toggleFavoriteUseCase: gh<_i308.ToggleFavoriteUseCase>(),
      ),
    );
    gh.factory<_i748.AuthCubit>(
      () => _i748.AuthCubit(
        gh<_i253.LoginUseCase>(),
        gh<_i35.RegisterUseCase>(),
        gh<_i981.LogoutUseCase>(),
        gh<_i959.CheckAuthStatusUseCase>(),
      ),
    );
    return this;
  }
}

class _$NetworkModule extends _i614.NetworkModule {}

class _$ApiClientModule extends _i651.ApiClientModule {}
