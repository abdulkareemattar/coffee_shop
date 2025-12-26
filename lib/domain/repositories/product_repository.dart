import '../entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
  Future<Product> getProductById(String id);
  Future<List<Product>> getProductsByCategory(String categoryId);
  Future<List<Product>> searchProducts(String query);
  Future<Product> createProduct({
    required String name,
    required String description,
    required double price,
    required String image,
    required String categoryId,
  });
  Future<Product> updateProduct({
    required String id,
    required String name,
    required String description,
    required double price,
    required String image,
    required String categoryId,
  });
  Future<void> deleteProduct(String id);
}
