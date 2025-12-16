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
import '../../data/repositories/coffee_repository_impl.dart' as _i1032;
import '../../domain/repositories/coffee_repository.dart' as _i812;
import '../../domain/usecases/get_favorites_usecase.dart' as _i520;
import '../../domain/usecases/toggle_favorite_usecase.dart' as _i308;
import '../../presentation/manager/cubit/auth/auth_cubit.dart' as _i748;
import '../../presentation/manager/cubit/favorites_cubit.dart' as _i288;
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
    gh.factory<_i719.ProductsCubit>(
      () => _i719.ProductsCubit(gh<_i1032.CoffeeRepositoryImpl>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => networkModule.provideDio(gh<_i558.FlutterSecureStorage>()),
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
    gh.lazySingleton<_i812.CoffeeRepository>(
      () => _i1032.CoffeeRepositoryImpl(gh<_i9.ProductApiClient>()),
    );
    gh.lazySingleton<_i481.AuthRepository>(
      () => _i481.AuthRepository(
        gh<_i972.AuthApiClient>(),
        gh<_i558.FlutterSecureStorage>(),
      ),
    );
    gh.factory<_i748.AuthCubit>(
      () => _i748.AuthCubit(gh<_i481.AuthRepository>()),
    );
    gh.lazySingleton<_i520.GetFavoritesUseCase>(
      () => _i520.GetFavoritesUseCase(gh<_i812.CoffeeRepository>()),
    );
    gh.lazySingleton<_i308.ToggleFavoriteUseCase>(
      () => _i308.ToggleFavoriteUseCase(gh<_i812.CoffeeRepository>()),
    );
    gh.factory<_i288.FavoritesCubit>(
      () => _i288.FavoritesCubit(
        getFavoritesUseCase: gh<_i520.GetFavoritesUseCase>(),
        toggleFavoriteUseCase: gh<_i308.ToggleFavoriteUseCase>(),
      ),
    );
    return this;
  }
}

class _$NetworkModule extends _i614.NetworkModule {}

class _$ApiClientModule extends _i651.ApiClientModule {}
