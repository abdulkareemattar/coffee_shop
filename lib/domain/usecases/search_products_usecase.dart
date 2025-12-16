import 'package:injectable/injectable.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

@lazySingleton
class SearchProductsUseCase {
  final ProductRepository repository;

  SearchProductsUseCase(this.repository);

  Future<List<Product>> call(String query) async {
    return await repository.searchProducts(query);
  }
}

