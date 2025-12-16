import 'package:injectable/injectable.dart';
import '../entities/cart_item.dart';
import '../repositories/cart_repository.dart';

@lazySingleton
class GetCartItemsUseCase {
  final CartRepository repository;

  GetCartItemsUseCase(this.repository);

  Future<List<CartItem>> call() async {
    return await repository.getCartItems();
  }
}

