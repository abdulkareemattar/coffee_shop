import 'package:injectable/injectable.dart';
import '../entities/category.dart';
import '../repositories/category_repository.dart';

@injectable
class UpdateCategoryUseCase {
  final CategoryRepository _repository;

  UpdateCategoryUseCase(this._repository);

  Future<Category> call({
    required String id,
    required String name,
    required String description,
  }) {
    return _repository.updateCategory(
      id: id,
      name: name,
      description: description,
    );
  }
}
