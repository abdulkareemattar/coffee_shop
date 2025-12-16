import 'package:injectable/injectable.dart';
import '../entities/order.dart' as domain;
import '../repositories/order_repository.dart';

@lazySingleton
class GetUserOrdersUseCase {
  final OrderRepository repository;

  GetUserOrdersUseCase(this.repository);

  Future<List<domain.Order>> call(String userId) async {
    return await repository.getUserOrders(userId);
  }
}

