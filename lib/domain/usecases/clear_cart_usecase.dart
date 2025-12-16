import 'package:injectable/injectable.dart';
import '../repositories/cart_repository.dart';

@lazySingleton
class ClearCartUseCase {
  final CartRepository repository;

  ClearCartUseCase(this.repository);

  Future<void> call() async {
    return await repository.clearCart();
  }
}

