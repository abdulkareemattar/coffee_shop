import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../models/category_response.dart';

part 'category_api_client.g.dart';

@RestApi()
abstract class CategoryApiClient {
  factory CategoryApiClient(Dio dio, {String baseUrl}) = _CategoryApiClient;

  @GET('/api/v1/categories')
  Future<List<CategoryResponse>> getCategories({
    @Query('isActive') bool? isActive,
  });

  @GET('/api/v1/categories/{id}')
  Future<CategoryResponse> getCategoryById(@Path('id') String id);

  @GET('/api/v1/categories/with-count')
  Future<List<CategoryResponse>> getCategoriesWithCount();

  @POST('/api/v1/categories')
  Future<CategoryResponse> createCategory(@Body() Map<String, dynamic> request);

  @PATCH('/api/v1/categories/{id}')
  Future<CategoryResponse> updateCategory(
    @Path('id') String id,
    @Body() Map<String, dynamic> request,
  );

  @DELETE('/api/v1/categories/{id}')
  Future<void> deleteCategory(@Path('id') String id);
}
