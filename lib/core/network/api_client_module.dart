import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../data/datasources/remote/auth_api_client.dart';
import '../../data/datasources/remote/category_api_client.dart';
import '../../data/datasources/remote/product_api_client.dart';

@module
abstract class ApiClientModule {
  @lazySingleton
  AuthApiClient provideAuthApiClient(Dio dio) => AuthApiClient(dio);

  @lazySingleton
  ProductApiClient provideProductApiClient(Dio dio) => ProductApiClient(dio);

  @lazySingleton
  CategoryApiClient provideCategoryApiClient(Dio dio) => CategoryApiClient(dio);
}
