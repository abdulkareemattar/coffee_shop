import 'package:injectable/injectable.dart';
import '../repositories/cart_repository.dart';

@lazySingleton
class GetCartTotalUseCase {
  final CartRepository repository;

  GetCartTotalUseCase(this.repository);

  Future<double> call() async {
    return await repository.getCartTotal();
  }
}

