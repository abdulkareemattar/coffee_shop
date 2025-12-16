import 'package:injectable/injectable.dart';
import '../repositories/cart_repository.dart';

@lazySingleton
class UpdateCartItemQuantityUseCase {
  final CartRepository repository;

  UpdateCartItemQuantityUseCase(this.repository);

  Future<void> call(String itemId, int quantity) async {
    return await repository.updateCartItemQuantity(itemId, quantity);
  }
}

