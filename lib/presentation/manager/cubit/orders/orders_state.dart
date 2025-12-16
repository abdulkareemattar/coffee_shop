import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../domain/entities/order.dart' as domain;

part 'orders_state.freezed.dart';

@freezed
class OrdersState with _$OrdersState {
  const factory OrdersState.initial() = _Initial;
  const factory OrdersState.loading() = _Loading;
  const factory OrdersState.loaded({required List<domain.Order> orders}) =
      _Loaded;
  const factory OrdersState.error({required String message}) = _Error;
}

