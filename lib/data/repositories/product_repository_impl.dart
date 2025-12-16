import 'package:injectable/injectable.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/remote/product_api_client.dart';
import '../models/product_model.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  final ProductApiClient _productApiClient;

  ProductRepositoryImpl(this._productApiClient);

  @override
  Future<List<Product>> getProducts() async {
    try {
      final products = await _productApiClient.getProducts();
      return products
          .map((product) => ProductModel(
                id: product.id,
                name: product.name,
                description: product.description,
                price: product.price,
                image: product.image,
                categoryId: product.categoryId,
                rating: null, // Add rating if available in API
                createdAt: product.createdAt,
                updatedAt: product.updatedAt,
              ))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }

  @override
  Future<Product> getProductById(String id) async {
    try {
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
    } catch (e) {
      throw Exception('Failed to fetch product: $e');
    }
  }

  @override
  Future<List<Product>> getProductsByCategory(String categoryId) async {
    try {
      final products = await _productApiClient.getProductsByCategory(categoryId);
      return products
          .map((product) => ProductModel(
                id: product.id,
                name: product.name,
                description: product.description,
                price: product.price,
                image: product.image,
                categoryId: product.categoryId,
                rating: null,
                createdAt: product.createdAt,
                updatedAt: product.updatedAt,
              ))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch products by category: $e');
    }
  }

  @override
  Future<List<Product>> searchProducts(String query) async {
    try {
      final products = await _productApiClient.getProducts();
      // Filter products locally (in real app, this should be done on backend)
      return products
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()) ||
              product.description.toLowerCase().contains(query.toLowerCase()))
          .map((product) => ProductModel(
                id: product.id,
                name: product.name,
                description: product.description,
                price: product.price,
                image: product.image,
                categoryId: product.categoryId,
                rating: null,
                createdAt: product.createdAt,
                updatedAt: product.updatedAt,
              ))
          .toList();
    } catch (e) {
      throw Exception('Failed to search products: $e');
    }
  }
}

