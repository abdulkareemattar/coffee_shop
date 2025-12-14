import 'package:injectable/injectable.dart';
import '../../domain/entities/coffee.dart';
import '../../domain/repositories/coffee_repository.dart';
import '../datasources/database_helper.dart';
import '../datasources/remote/product_api_client.dart';
import '../models/coffee_model.dart';

@LazySingleton(as: CoffeeRepository)
class CoffeeRepositoryImpl implements CoffeeRepository {
  final ProductApiClient _productApiClient;

  CoffeeRepositoryImpl(this._productApiClient);

  @override
  Future<List<Coffee>> getFavorites() async {
    // This still uses local database for favorites
    // You can integrate with backend later
    final models = await DatabaseHelper.getFavorites();
    return models;
  }

  @override
  Future<void> addToFavorites(Coffee coffee) async {
    final coffeeModel = CoffeeModel(
      id: coffee.id,
      imagePath: coffee.imagePath,
      name: coffee.name,
      type: coffee.type,
      price: coffee.price,
      rating: coffee.rating,
      description: coffee.description,
    );
    await DatabaseHelper.addToFavorites(coffeeModel);
  }

  @override
  Future<void> removeFromFavorites(int id) async {
    await DatabaseHelper.removeFromFavorites(id);
  }

  // Example: Fetch products from backend
  Future<List<Coffee>> getProductsFromBackend() async {
    try {
      final products = await _productApiClient.getProducts();

      // Convert ProductResponse to Coffee entity
      return products
          .map(
            (product) => Coffee(
              id: int.tryParse(product.id) ?? 0,
              imagePath: product.image,
              name: product.name,
              type: '', // You may need to add category info
              price: product.price,
              rating: 0.0, // Add rating if available
              description: product.description,
            ),
          )
          .toList();
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  // Example: Fetch products by category
  Future<List<Coffee>> getProductsByCategory(String categoryId) async {
    try {
      final products = await _productApiClient.getProductsByCategory(
        categoryId,
      );

      return products
          .map(
            (product) => Coffee(
              id: int.tryParse(product.id) ?? 0,
              imagePath: product.image,
              name: product.name,
              type: '',
              price: product.price,
              rating: 0.0,
              description: product.description,
            ),
          )
          .toList();
    } catch (e) {
      print('Error fetching products by category: $e');
      return [];
    }
  }
}
