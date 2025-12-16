import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../domain/entities/product.dart';
import '../../../../domain/usecases/get_products_usecase.dart';
import '../../../../domain/usecases/get_products_by_category_usecase.dart';
import '../../../../domain/usecases/search_products_usecase.dart';
import '../../../../data/models/coffee_model.dart';
import 'products_state.dart';

@injectable
class ProductsCubit extends Cubit<ProductsState> {
  final GetProductsUseCase _getProductsUseCase;
  final GetProductsByCategoryUseCase _getProductsByCategoryUseCase;
  final SearchProductsUseCase _searchProductsUseCase;

  ProductsCubit(
    this._getProductsUseCase,
    this._getProductsByCategoryUseCase,
    this._searchProductsUseCase,
  ) : super(const ProductsState.initial());

  Future<void> loadProducts() async {
    emit(const ProductsState.loading());
    try {
      final products = await _getProductsUseCase();
      final coffeeModels = products
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
      emit(ProductsState.loaded(coffees: coffeeModels));
    } catch (e) {
      emit(ProductsState.error(message: e.toString()));
    }
  }

  Future<void> loadProductsByCategory(String categoryId) async {
    emit(const ProductsState.loading());
    try {
      final products = await _getProductsByCategoryUseCase(categoryId);
      final coffeeModels = products
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
      emit(ProductsState.loaded(coffees: coffeeModels));
    } catch (e) {
      emit(ProductsState.error(message: e.toString()));
    }
  }

  Future<void> searchProducts(String query) async {
    emit(const ProductsState.loading());
    try {
      final products = await _searchProductsUseCase(query);
      final coffeeModels = products
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
      emit(ProductsState.loaded(coffees: coffeeModels));
    } catch (e) {
      emit(ProductsState.error(message: e.toString()));
    }
  }
}
