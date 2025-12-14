import '../entities/coffee.dart';

abstract class CoffeeRepository {
  Future<List<Coffee>> getFavorites();
  Future<void> addToFavorites(Coffee coffee);
  Future<void> removeFromFavorites(int id);
}
