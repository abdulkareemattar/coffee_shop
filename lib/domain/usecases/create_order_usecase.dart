import 'package:injectable/injectable.dart';
import '../entities/order.dart' as domain;
import '../repositories/order_repository.dart';

@lazySingleton
class CreateOrderUseCase {
  final OrderRepository repository;

  CreateOrderUseCase(this.repository);

  Future<domain.Order> call(domain.Order order) async {
    return await repository.createOrder(order);
  }
}

