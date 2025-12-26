import '../entities/category.dart';

abstract class CategoryRepository {
  Future<List<Category>> getCategories();
  Future<Category> getCategoryById(String id);
  Future<Category> createCategory({
    required String name,
    required String description,
  });
  Future<Category> updateCategory({
    required String id,
    required String name,
    required String description,
  });
  Future<void> deleteCategory(String id);
}
