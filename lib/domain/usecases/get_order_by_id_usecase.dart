import 'package:injectable/injectable.dart';
import '../entities/order.dart' as domain;
import '../repositories/order_repository.dart';

@lazySingleton
class GetOrderByIdUseCase {
  final OrderRepository repository;

  GetOrderByIdUseCase(this.repository);

  Future<domain.Order> call(String orderId) async {
    return await repository.getOrderById(orderId);
  }
}

