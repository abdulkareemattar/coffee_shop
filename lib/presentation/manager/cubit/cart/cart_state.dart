import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../domain/entities/cart_item.dart';

part 'cart_state.freezed.dart';

@freezed
class CartState with _$CartState {
  const factory CartState.initial() = _Initial;
  const factory CartState.loading() = _Loading;
  const factory CartState.loaded({
    required List<CartItem> items,
    required double total,
  }) = _Loaded;
  const factory CartState.error({required String message}) = _Error;
}

