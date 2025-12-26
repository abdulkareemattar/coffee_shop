import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/data_error_handler.dart';
import '../../../../domain/usecases/get_categories_usecase.dart';
import '../../../../domain/usecases/get_category_by_id_usecase.dart';
import '../../../../domain/usecases/create_category_usecase.dart';
import '../../../../domain/usecases/update_category_usecase.dart';
import '../../../../domain/usecases/delete_category_usecase.dart';
import 'categories_state.dart';

@injectable
class CategoriesCubit extends HydratedCubit<CategoriesState> {
  final GetCategoriesUseCase _getCategoriesUseCase;
  final GetCategoryByIdUseCase _getCategoryByIdUseCase;
  final CreateCategoryUseCase _createCategoryUseCase;
  final UpdateCategoryUseCase _updateCategoryUseCase;
  final DeleteCategoryUseCase _deleteCategoryUseCase;

  CategoriesCubit(
    this._getCategoriesUseCase,
    this._getCategoryByIdUseCase,
    this._createCategoryUseCase,
    this._updateCategoryUseCase,
    this._deleteCategoryUseCase,
  ) : super(const CategoriesState.initial());

  Future<void> loadCategories() async {
    emit(const CategoriesState.loading());
    try {
      final categories = await _getCategoriesUseCase();
      if (isClosed) return;
      emit(CategoriesState.loaded(categories: categories));
    } catch (e) {
      if (isClosed) return;
      emit(CategoriesState.error(message: DataErrorHandler.handle(e)));
    }
  }

  Future<void> loadCategoryById(String id) async {
    emit(const CategoriesState.loading());
    try {
      final category = await _getCategoryByIdUseCase(id);
      if (isClosed) return;
      emit(CategoriesState.loaded(categories: [category]));
    } catch (e) {
      if (isClosed) return;
      emit(CategoriesState.error(message: DataErrorHandler.handle(e)));
    }
  }

  Future<void> createCategory({
    required String name,
    required String description,
  }) async {
    try {
      await _createCategoryUseCase(name: name, description: description);
      if (isClosed) return;
      await loadCategories();
    } catch (e) {
      if (isClosed) return;
      emit(CategoriesState.error(message: DataErrorHandler.handle(e)));
      rethrow;
    }
  }

  Future<void> updateCategory({
    required String id,
    required String name,
    required String description,
  }) async {
    try {
      await _updateCategoryUseCase(
        id: id,
        name: name,
        description: description,
      );
      if (isClosed) return;
      await loadCategories();
    } catch (e) {
      if (isClosed) return;
      emit(CategoriesState.error(message: DataErrorHandler.handle(e)));
      rethrow;
    }
  }

  Future<void> deleteCategory(String id) async {
    try {
      await _deleteCategoryUseCase(id);
      if (isClosed) return;
      await loadCategories();
    } catch (e) {
      if (isClosed) return;
      emit(CategoriesState.error(message: DataErrorHandler.handle(e)));
      rethrow;
    }
  }

  @override
  CategoriesState? fromJson(Map<String, dynamic> json) =>
      CategoriesState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(CategoriesState state) => state.toJson();
}
