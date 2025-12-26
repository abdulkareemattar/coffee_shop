import 'package:injectable/injectable.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

@injectable
class CreateProductUseCase {
  final ProductRepository _repository;

  CreateProductUseCase(this._repository);

  Future<Product> call({
    required String name,
    required String description,
    required double price,
    required String image,
    required String categoryId,
  }) {
    return _repository.createProduct(
      name: name,
      description: description,
      price: price,
      image: image,
      categoryId: categoryId,
    );
  }
}
