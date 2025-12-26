import 'package:injectable/injectable.dart';
import '../repositories/product_repository.dart';

@injectable
class DeleteProductUseCase {
  final ProductRepository _repository;

  DeleteProductUseCase(this._repository);

  Future<void> call(String id) {
    return _repository.deleteProduct(id);
  }
}
