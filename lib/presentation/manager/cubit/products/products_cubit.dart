import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../domain/usecases/get_products_usecase.dart';
import '../../../../domain/usecases/get_products_by_category_usecase.dart';
import '../../../../domain/usecases/search_products_usecase.dart';
import '../../../../data/models/coffee_model.dart';
import '../../../../domain/entities/product.dart';
import 'products_state.dart';

@injectable
class ProductsCubit extends HydratedCubit<ProductsState> {
  final GetProductsUseCase _getProductsUseCase;
  final GetProductsByCategoryUseCase _getProductsByCategoryUseCase;
  final SearchProductsUseCase _searchProductsUseCase;

  List<CoffeeModel> _allCoffees = [];

  ProductsCubit(
    this._getProductsUseCase,
    this._getProductsByCategoryUseCase,
    this._searchProductsUseCase,
  ) : super(const ProductsState.initial()) {
    // Initialize _allCoffees if we have a persisted state
    state.maybeWhen(loaded: (coffees) => _allCoffees = coffees, orElse: () {});
  }

  Future<void> loadProducts() async {
    emit(const ProductsState.loading());
    try {
      final products = await _getProductsUseCase();
      if (isClosed) return;

      final coffeeModels = await compute(_mapToCoffeeModels, products);

      if (isClosed) return;
      _allCoffees = coffeeModels;
      emit(ProductsState.loaded(coffees: coffeeModels));
    } catch (e) {
      if (isClosed) return;
      emit(ProductsState.error(message: e.toString()));
    }
  }

  Future<void> loadProductsByCategory(String categoryId) async {
    if (categoryId == 'all') {
      await loadProducts();
      return;
    }
    emit(const ProductsState.loading());
    try {
      final products = await _getProductsByCategoryUseCase(categoryId);
      if (isClosed) return;

      final coffeeModels = await compute(_mapToCoffeeModels, products);

      if (isClosed) return;
      _allCoffees = coffeeModels;
      emit(ProductsState.loaded(coffees: coffeeModels));
    } catch (e) {
      if (isClosed) return;
      emit(ProductsState.error(message: e.toString()));
    }
  }

  Future<void> searchProducts(String query) async {
    emit(const ProductsState.loading());
    try {
      final products = await _searchProductsUseCase(query);
      if (isClosed) return;

      final coffeeModels = await compute(_mapToCoffeeModels, products);

      if (isClosed) return;
      _allCoffees = coffeeModels;
      emit(ProductsState.loaded(coffees: coffeeModels));
    } catch (e) {
      if (isClosed) return;
      emit(ProductsState.error(message: e.toString()));
    }
  }

  void applyFilters({
    required double minPrice,
    required double maxPrice,
    required double minRating,
  }) {
    final filteredCoffees = _allCoffees.where((coffee) {
      final matchesPrice = coffee.price >= minPrice && coffee.price <= maxPrice;
      final matchesRating = coffee.rating >= minRating;
      return matchesPrice && matchesRating;
    }).toList();

    emit(ProductsState.loaded(coffees: filteredCoffees));
  }

  static List<CoffeeModel> _mapToCoffeeModels(List<Product> products) {
    return products
        .map(
          (product) => CoffeeModel(
            id: int.tryParse(product.id) ?? 0,
            imagePath: product.image,
            name: product.name,
            type: product.categoryId,
            price: product.price,
            rating: product.rating ?? 0.0,
            description: product.description,
          ),
        )
        .toList();
  }

  @override
  ProductsState? fromJson(Map<String, dynamic> json) =>
      ProductsState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(ProductsState state) => state.toJson();
}
