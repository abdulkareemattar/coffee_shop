import 'package:injectable/injectable.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

@injectable
class UpdateProductUseCase {
  final ProductRepository _repository;

  UpdateProductUseCase(this._repository);

  Future<Product> call({
    required String id,
    required String name,
    required String description,
    required double price,
    required String image,
    required String categoryId,
  }) {
    return _repository.updateProduct(
      id: id,
      name: name,
      description: description,
      price: price,
      image: image,
      categoryId: categoryId,
    );
  }
}
