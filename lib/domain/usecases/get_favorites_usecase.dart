import 'package:injectable/injectable.dart';
import '../entities/coffee.dart';
import '../repositories/coffee_repository.dart';

@lazySingleton
class GetFavoritesUseCase {
  final CoffeeRepository repository;

  GetFavoritesUseCase(this.repository);

  Future<List<Coffee>> call() async {
    return await repository.getFavorites();
  }
}
