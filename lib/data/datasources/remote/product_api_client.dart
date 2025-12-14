import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../models/product_response.dart';

part 'product_api_client.g.dart';

@RestApi()
abstract class ProductApiClient {
  factory ProductApiClient(Dio dio, {String baseUrl}) = _ProductApiClient;

  @GET('/api/v1/products')
  Future<List<ProductResponse>> getProducts();

  @GET('/api/v1/products/{id}')
  Future<ProductResponse> getProductById(@Path('id') String id);

  @GET('/api/v1/products/category/{categoryId}')
  Future<List<ProductResponse>> getProductsByCategory(
    @Path('categoryId') String categoryId,
  );

  @POST('/api/v1/products')
  Future<ProductResponse> createProduct(@Body() CreateProductRequest request);

  @PATCH('/api/v1/products/{id}')
  Future<ProductResponse> updateProduct(
    @Path('id') String id,
    @Body() CreateProductRequest request,
  );

  @DELETE('/api/v1/products/{id}')
  Future<void> deleteProduct(@Path('id') String id);
}
