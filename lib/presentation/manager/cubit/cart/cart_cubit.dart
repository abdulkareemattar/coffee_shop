import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../domain/entities/cart_item.dart';
import '../../../../domain/usecases/get_cart_items_usecase.dart';
import '../../../../domain/usecases/add_to_cart_usecase.dart';
import '../../../../domain/usecases/remove_from_cart_usecase.dart';
import '../../../../domain/usecases/update_cart_item_quantity_usecase.dart';
import '../../../../domain/usecases/clear_cart_usecase.dart';
import '../../../../domain/usecases/get_cart_total_usecase.dart';
import 'cart_state.dart';

@injectable
class CartCubit extends Cubit<CartState> {
  final GetCartItemsUseCase _getCartItemsUseCase;
  final AddToCartUseCase _addToCartUseCase;
  final RemoveFromCartUseCase _removeFromCartUseCase;
  final UpdateCartItemQuantityUseCase _updateCartItemQuantityUseCase;
  final ClearCartUseCase _clearCartUseCase;
  final GetCartTotalUseCase _getCartTotalUseCase;

  CartCubit(
    this._getCartItemsUseCase,
    this._addToCartUseCase,
    this._removeFromCartUseCase,
    this._updateCartItemQuantityUseCase,
    this._clearCartUseCase,
    this._getCartTotalUseCase,
  ) : super(const CartState.initial());

  Future<void> loadCart() async {
    emit(const CartState.loading());
    try {
      final items = await _getCartItemsUseCase();
      final total = await _getCartTotalUseCase();
      emit(CartState.loaded(items: items, total: total));
    } catch (e) {
      emit(CartState.error(message: e.toString()));
    }
  }

  Future<void> addToCart(CartItem item) async {
    try {
      await _addToCartUseCase(item);
      await loadCart();
    } catch (e) {
      emit(CartState.error(message: e.toString()));
    }
  }

  Future<void> removeFromCart(String itemId) async {
    try {
      await _removeFromCartUseCase(itemId);
      await loadCart();
    } catch (e) {
      emit(CartState.error(message: e.toString()));
    }
  }

  Future<void> updateQuantity(String itemId, int quantity) async {
    try {
      await _updateCartItemQuantityUseCase(itemId, quantity);
      await loadCart();
    } catch (e) {
      emit(CartState.error(message: e.toString()));
    }
  }

  Future<void> clearCart() async {
    try {
      await _clearCartUseCase();
      emit(const CartState.loaded(items: [], total: 0.0));
    } catch (e) {
      emit(CartState.error(message: e.toString()));
    }
  }
}

