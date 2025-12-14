import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import '../../data/datasources/remote/auth_api_client.dart';
import '../../data/datasources/remote/category_api_client.dart';
import '../../data/datasources/remote/product_api_client.dart';
import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
void configureDependencies() {
  getIt.init();

  // Register Retrofit API clients manually
  getIt.registerLazySingleton<AuthApiClient>(() => AuthApiClient(getIt()));

  getIt.registerLazySingleton<ProductApiClient>(
    () => ProductApiClient(getIt()),
  );

  getIt.registerLazySingleton<CategoryApiClient>(
    () => CategoryApiClient(getIt()),
  );
}
