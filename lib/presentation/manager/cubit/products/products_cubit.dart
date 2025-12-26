import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/data_error_handler.dart';
import '../../../../domain/usecases/get_products_usecase.dart';
import '../../../../domain/usecases/get_products_by_category_usecase.dart';
import '../../../../domain/usecases/search_products_usecase.dart';
import '../../../../domain/usecases/create_product_usecase.dart';
import '../../../../domain/usecases/update_product_usecase.dart';
import '../../../../domain/usecases/delete_product_usecase.dart';
import '../../../../data/models/coffee_model.dart';
import '../../../../domain/entities/product.dart';
import 'products_state.dart';

@injectable
class ProductsCubit extends HydratedCubit<ProductsState> {
  final GetProductsUseCase _getProductsUseCase;
  final GetProductsByCategoryUseCase _getProductsByCategoryUseCase;
  final SearchProductsUseCase _searchProductsUseCase;
  final CreateProductUseCase _createProductUseCase;
  final UpdateProductUseCase _updateProductUseCase;
  final DeleteProductUseCase _deleteProductUseCase;

  List<CoffeeModel> _allCoffees = [];

  ProductsCubit(
    this._getProductsUseCase,
    this._getProductsByCategoryUseCase,
    this._searchProductsUseCase,
    this._createProductUseCase,
    this._updateProductUseCase,
    this._deleteProductUseCase,
  ) : super(const ProductsState.initial()) {
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
      emit(ProductsState.error(message: DataErrorHandler.handle(e)));
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
      emit(ProductsState.error(message: DataErrorHandler.handle(e)));
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
      emit(ProductsState.error(message: DataErrorHandler.handle(e)));
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

  Future<void> createProduct({
    required String name,
    required String description,
    required double price,
    required String image,
    required String categoryId,
  }) async {
    try {
      await _createProductUseCase(
        name: name,
        description: description,
        price: price,
        image: image,
        categoryId: categoryId,
      );
      if (isClosed) return;
      // Reload products to get the updated list
      await loadProducts();
    } catch (e) {
      if (isClosed) return;
      emit(ProductsState.error(message: DataErrorHandler.handle(e)));
      rethrow;
    }
  }

  Future<void> updateProduct({
    required String id,
    required String name,
    required String description,
    required double price,
    required String image,
    required String categoryId,
  }) async {
    try {
      await _updateProductUseCase(
        id: id,
        name: name,
        description: description,
        price: price,
        image: image,
        categoryId: categoryId,
      );
      if (isClosed) return;
      // Reload products to get the updated list
      await loadProducts();
    } catch (e) {
      if (isClosed) return;
      emit(ProductsState.error(message: DataErrorHandler.handle(e)));
      rethrow;
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      await _deleteProductUseCase(id);
      if (isClosed) return;
      // Reload products to get the updated list
      await loadProducts();
    } catch (e) {
      if (isClosed) return;
      emit(ProductsState.error(message: DataErrorHandler.handle(e)));
      rethrow;
    }
  }

  static List<CoffeeModel> _mapToCoffeeModels(List<Product> products) {
    return products
        .map(
          (product) => CoffeeModel(
            id: product.id,
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
