import 'package:injectable/injectable.dart';
import '../repositories/cart_repository.dart';

@lazySingleton
class RemoveFromCartUseCase {
  final CartRepository repository;

  RemoveFromCartUseCase(this.repository);

  Future<void> call(String itemId) async {
    return await repository.removeFromCart(itemId);
  }
}

