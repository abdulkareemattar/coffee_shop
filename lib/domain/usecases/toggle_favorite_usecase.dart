import 'package:injectable/injectable.dart';
import '../entities/coffee.dart';
import '../repositories/coffee_repository.dart';

@lazySingleton
class ToggleFavoriteUseCase {
  final CoffeeRepository repository;

  ToggleFavoriteUseCase(this.repository);

  Future<void> call(Coffee coffee, bool isFavorite) async {
    if (isFavorite) {
      await repository.removeFromFavorites(coffee.id);
    } else {
      await repository.addToFavorites(coffee);
    }
  }
}
