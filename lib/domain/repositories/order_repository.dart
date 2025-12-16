import '../entities/order.dart';

abstract class OrderRepository {
  Future<Order> createOrder(Order order);
  Future<List<Order>> getUserOrders(String userId);
  Future<Order> getOrderById(String orderId);
  Future<Order> updateOrderStatus(String orderId, OrderStatus status);
  Future<void> cancelOrder(String orderId);
}

