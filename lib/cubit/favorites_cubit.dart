import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/database_helper.dart';
import '../models/coffee_model.dart';

part 'favorites_state.dart';


class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(const FavoritesState());

  Future<void> loadFavorites() async {
    final favoritesList = await DatabaseHelper.getFavorites();
    emit(FavoritesState(favorites: favoritesList));
  }

  Future<void> toggleFavorite(CoffeeModel coffee) async {
    final isFavorite = state.favorites.any((item) => item.id == coffee.id);

    if (isFavorite) {
      await DatabaseHelper.removeFromFavorites(coffee.id);
    } 
    else {
      await DatabaseHelper.addToFavorites(coffee);
    }

    await loadFavorites();
  }
}
