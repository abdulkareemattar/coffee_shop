import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../domain/usecases/get_categories_usecase.dart';
import '../../../../domain/usecases/get_category_by_id_usecase.dart';
import 'categories_state.dart';

@injectable
class CategoriesCubit extends Cubit<CategoriesState> {
  final GetCategoriesUseCase _getCategoriesUseCase;
  final GetCategoryByIdUseCase _getCategoryByIdUseCase;

  CategoriesCubit(
    this._getCategoriesUseCase,
    this._getCategoryByIdUseCase,
  ) : super(const CategoriesState.initial());

  Future<void> loadCategories() async {
    emit(const CategoriesState.loading());
    try {
      final categories = await _getCategoriesUseCase();
      emit(CategoriesState.loaded(categories: categories));
    } catch (e) {
      emit(CategoriesState.error(message: e.toString()));
    }
  }

  Future<void> loadCategoryById(String id) async {
    emit(const CategoriesState.loading());
    try {
      final category = await _getCategoryByIdUseCase(id);
      emit(CategoriesState.loaded(categories: [category]));
    } catch (e) {
      emit(CategoriesState.error(message: e.toString()));
    }
  }
}

