import 'package:injectable/injectable.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/remote/product_api_client.dart';
import '../models/product_model.dart';
import '../models/product_response.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  final ProductApiClient _productApiClient;

  ProductRepositoryImpl(this._productApiClient);

  @override
  Future<List<Product>> getProducts() async {
    final response = await _productApiClient.getProducts();
    return response.products
        .map(
          (product) => ProductModel(
            id: product.id,
            name: product.name,
            description: product.description,
            price: product.price,
            image: product.image,
            categoryId: product.categoryId,
            rating: product.rating,
            createdAt: product.createdAt,
            updatedAt: product.updatedAt,
          ),
        )
        .toList();
  }

  @override
  Future<Product> getProductById(String id) async {
    final product = await _productApiClient.getProductById(id);
    return ProductModel(
      id: product.id,
      name: product.name,
      description: product.description,
      price: product.price,
      image: product.image,
      categoryId: product.categoryId,
      rating: null,
      createdAt: product.createdAt,
      updatedAt: product.updatedAt,
    );
  }

  @override
  Future<List<Product>> getProductsByCategory(String categoryId) async {
    final products = await _productApiClient.getProductsByCategory(categoryId);
    return products
        .map(
          (product) => ProductModel(
            id: product.id,
            name: product.name,
            description: product.description,
            price: product.price,
            image: product.image,
            categoryId: product.categoryId,
            rating: null,
            createdAt: product.createdAt,
            updatedAt: product.updatedAt,
          ),
        )
        .toList();
  }

  @override
  Future<List<Product>> searchProducts(String query) async {
    final response = await _productApiClient.getProducts();
    // Filter products locally (in real app, this should be done on backend)
    return response.products
        .where(
          (product) =>
              product.name.toLowerCase().contains(query.toLowerCase()) ||
              product.description.toLowerCase().contains(query.toLowerCase()),
        )
        .map(
          (product) => ProductModel(
            id: product.id,
            name: product.name,
            description: product.description,
            price: product.price,
            image: product.image,
            categoryId: product.categoryId,
            rating: product.rating,
            createdAt: product.createdAt,
            updatedAt: product.updatedAt,
          ),
        )
        .toList();
  }

  @override
  Future<Product> createProduct({
    required String name,
    required String description,
    required double price,
    required String image,
    required String categoryId,
  }) async {
    final request = CreateProductRequest(
      name: name,
      description: description,
      price: price,
      image: image,
      categoryId: categoryId,
    );

    final product = await _productApiClient.createProduct(request);
    return ProductModel(
      id: product.id,
      name: product.name,
      description: product.description,
      price: product.price,
      image: product.image,
      categoryId: product.categoryId,
      rating: product.rating,
      createdAt: product.createdAt,
      updatedAt: product.updatedAt,
    );
  }

  @override
  Future<Product> updateProduct({
    required String id,
    required String name,
    required String description,
    required double price,
    required String image,
    required String categoryId,
  }) async {
    final request = CreateProductRequest(
      name: name,
      description: description,
      price: price,
      image: image,
      categoryId: categoryId,
    );

    final product = await _productApiClient.updateProduct(id, request);
    return ProductModel(
      id: product.id,
      name: product.name,
      description: product.description,
      price: product.price,
      image: product.image,
      categoryId: product.categoryId,
      rating: product.rating,
      createdAt: product.createdAt,
      updatedAt: product.updatedAt,
    );
  }

  @override
  Future<void> deleteProduct(String id) async {
    await _productApiClient.deleteProduct(id);
  }
}
