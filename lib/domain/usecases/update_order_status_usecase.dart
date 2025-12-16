import 'package:injectable/injectable.dart';
import '../entities/order.dart' as domain;
import '../repositories/order_repository.dart';

@lazySingleton
class UpdateOrderStatusUseCase {
  final OrderRepository repository;

  UpdateOrderStatusUseCase(this.repository);

  Future<domain.Order> call(String orderId, domain.OrderStatus status) async {
    return await repository.updateOrderStatus(orderId, status);
  }
}

