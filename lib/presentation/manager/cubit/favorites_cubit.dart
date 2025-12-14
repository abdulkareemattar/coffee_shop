import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../domain/entities/coffee.dart';
import '../../../../domain/usecases/get_favorites_usecase.dart';
import '../../../../domain/usecases/toggle_favorite_usecase.dart';

part 'favorites_state.dart';

@injectable
class FavoritesCubit extends Cubit<FavoritesState> {
  final GetFavoritesUseCase getFavoritesUseCase;
  final ToggleFavoriteUseCase toggleFavoriteUseCase;

  FavoritesCubit({
    required this.getFavoritesUseCase,
    required this.toggleFavoriteUseCase,
  }) : super(const FavoritesState());

  Future<void> loadFavorites() async {
    final favoritesList = await getFavoritesUseCase();
    emit(FavoritesState(favorites: favoritesList));
  }

  Future<void> toggleFavorite(Coffee coffee) async {
    final isFavorite = state.favorites.any((item) => item.id == coffee.id);
    await toggleFavoriteUseCase(coffee, isFavorite);
    await loadFavorites();
  }
}
