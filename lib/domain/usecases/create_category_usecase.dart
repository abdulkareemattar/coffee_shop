import 'package:injectable/injectable.dart';
import '../entities/category.dart';
import '../repositories/category_repository.dart';

@injectable
class CreateCategoryUseCase {
  final CategoryRepository _repository;

  CreateCategoryUseCase(this._repository);

  Future<Category> call({required String name, required String description}) {
    return _repository.createCategory(name: name, description: description);
  }
}
