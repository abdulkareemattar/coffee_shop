import 'package:injectable/injectable.dart';
import '../repositories/category_repository.dart';

@injectable
class DeleteCategoryUseCase {
  final CategoryRepository _repository;

  DeleteCategoryUseCase(this._repository);

  Future<void> call(String id) {
    return _repository.deleteCategory(id);
  }
}
