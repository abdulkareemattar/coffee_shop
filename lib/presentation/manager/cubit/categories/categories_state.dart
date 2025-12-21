import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../domain/entities/category.dart';

part 'categories_state.freezed.dart';
part 'categories_state.g.dart';

@freezed
abstract class CategoriesState with _$CategoriesState {
  const factory CategoriesState.initial() = _Initial;
  const factory CategoriesState.loading() = _Loading;
  const factory CategoriesState.loaded({required List<Category> categories}) =
      _Loaded;
  const factory CategoriesState.error({required String message}) = _Error;

  factory CategoriesState.fromJson(Map<String, dynamic> json) =>
      _$CategoriesStateFromJson(json);
}
