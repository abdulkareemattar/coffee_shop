import 'package:injectable/injectable.dart';
import '../repositories/order_repository.dart';

@lazySingleton
class CancelOrderUseCase {
  final OrderRepository repository;

  CancelOrderUseCase(this.repository);

  Future<void> call(String orderId) async {
    return await repository.cancelOrder(orderId);
  }
}

