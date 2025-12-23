import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/data_error_handler.dart';
import '../../../../domain/usecases/get_categories_usecase.dart';
import '../../../../domain/usecases/get_category_by_id_usecase.dart';
import 'categories_state.dart';

@injectable
class CategoriesCubit extends HydratedCubit<CategoriesState> {
  final GetCategoriesUseCase _getCategoriesUseCase;
  final GetCategoryByIdUseCase _getCategoryByIdUseCase;

  CategoriesCubit(this._getCategoriesUseCase, this._getCategoryByIdUseCase)
    : super(const CategoriesState.initial());

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

  @override
  CategoriesState? fromJson(Map<String, dynamic> json) =>
      CategoriesState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(CategoriesState state) => state.toJson();
}
