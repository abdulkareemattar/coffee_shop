import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../domain/entities/order.dart' as domain;
import '../../../../domain/usecases/create_order_usecase.dart';
import '../../../../domain/usecases/get_user_orders_usecase.dart';
// import '../../../../domain/usecases/get_order_by_id_usecase.dart'; // Reserved for future use
import '../../../../domain/usecases/update_order_status_usecase.dart';
import '../../../../domain/usecases/cancel_order_usecase.dart';
import 'orders_state.dart';

@injectable
class OrdersCubit extends Cubit<OrdersState> {
  final CreateOrderUseCase _createOrderUseCase;
  final GetUserOrdersUseCase _getUserOrdersUseCase;
  // final GetOrderByIdUseCase _getOrderByIdUseCase; // Reserved for future use
  final UpdateOrderStatusUseCase _updateOrderStatusUseCase;
  final CancelOrderUseCase _cancelOrderUseCase;

  OrdersCubit(
    this._createOrderUseCase,
    this._getUserOrdersUseCase,
    // this._getOrderByIdUseCase, // Reserved for future use
    this._updateOrderStatusUseCase,
    this._cancelOrderUseCase,
  ) : super(const OrdersState.initial());

  Future<void> loadUserOrders(String userId) async {
    emit(const OrdersState.loading());
    try {
      final orders = await _getUserOrdersUseCase(userId);
      emit(OrdersState.loaded(orders: orders));
    } catch (e) {
      emit(OrdersState.error(message: e.toString()));
    }
  }

  Future<void> createOrder(domain.Order order) async {
    emit(const OrdersState.loading());
    try {
      await _createOrderUseCase(order);
      // Reload orders after creating
      if (order.userId.isNotEmpty) {
        await loadUserOrders(order.userId);
      }
    } catch (e) {
      emit(OrdersState.error(message: e.toString()));
    }
  }

  Future<void> updateOrderStatus(
    String orderId,
    domain.OrderStatus status,
    String userId,
  ) async {
    try {
      await _updateOrderStatusUseCase(orderId, status);
      // Reload orders after updating
      if (userId.isNotEmpty) {
        await loadUserOrders(userId);
      }
    } catch (e) {
      emit(OrdersState.error(message: e.toString()));
    }
  }

  Future<void> cancelOrder(String orderId, String userId) async {
    try {
      await _cancelOrderUseCase(orderId);
      // Reload orders after canceling
      if (userId.isNotEmpty) {
        await loadUserOrders(userId);
      }
    } catch (e) {
      emit(OrdersState.error(message: e.toString()));
    }
  }
}

