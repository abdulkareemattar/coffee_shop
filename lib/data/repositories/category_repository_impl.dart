import 'package:injectable/injectable.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources/remote/category_api_client.dart';
import '../models/category_model.dart';

@LazySingleton(as: CategoryRepository)
class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryApiClient _categoryApiClient;

  CategoryRepositoryImpl(this._categoryApiClient);

  @override
  Future<List<Category>> getCategories() async {
    try {
      final categories = await _categoryApiClient.getCategories();
      return categories
          .map((category) => CategoryModel(
                id: category.id,
                name: category.name,
                image: null, // CategoryResponse doesn't have image field
                description: category.description,
              ))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch categories: $e');
    }
  }

  @override
  Future<Category> getCategoryById(String id) async {
    try {
      final category = await _categoryApiClient.getCategoryById(id);
      return CategoryModel(
        id: category.id,
        name: category.name,
        image: null, // CategoryResponse doesn't have image field
        description: category.description,
      );
    } catch (e) {
      throw Exception('Failed to fetch category: $e');
    }
  }
}

