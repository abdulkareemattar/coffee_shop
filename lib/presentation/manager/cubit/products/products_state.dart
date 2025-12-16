import 'package:coffee_shop/data/models/coffee_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'products_state.freezed.dart';

@freezed
class ProductsState with _$ProductsState {
  const factory ProductsState.initial() = _Initial;
  const factory ProductsState.loading() = _Loading;
  const factory ProductsState.loaded({required List<CoffeeModel> coffees}) =
      _Loaded;
  const factory ProductsState.error({required String message}) = _Error;
}
