import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../domain/entities/category.dart';

part 'categories_state.freezed.dart';

@freezed
class CategoriesState with _$CategoriesState {
  const factory CategoriesState.initial() = _Initial;
  const factory CategoriesState.loading() = _Loading;
  const factory CategoriesState.loaded({required List<Category> categories}) =
      _Loaded;
  const factory CategoriesState.error({required String message}) = _Error;
}

