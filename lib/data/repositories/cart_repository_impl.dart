import 'package:injectable/injectable.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/repositories/cart_repository.dart';

@LazySingleton(as: CartRepository)
class CartRepositoryImpl implements CartRepository {
  // In-memory storage for cart items (in a real app, use database or API)
  final List<CartItem> _cartItems = [];

  CartRepositoryImpl();

  @override
  Future<List<CartItem>> getCartItems() async {
    try {
      // Return a copy of the list
      return List.from(_cartItems);
    } catch (e) {
      throw Exception('Failed to get cart items: $e');
    }
  }

  @override
  Future<void> addToCart(CartItem item) async {
    try {
      // Check if item already exists in cart
      final existingIndex = _cartItems.indexWhere((i) => i.id == item.id);
      if (existingIndex != -1) {
        // Update quantity if item exists
        final existingItem = _cartItems[existingIndex];
        _cartItems[existingIndex] = existingItem.copyWith(
          quantity: existingItem.quantity + item.quantity,
        );
      } else {
        // Add new item
        _cartItems.add(item);
      }
    } catch (e) {
      throw Exception('Failed to add item to cart: $e');
    }
  }

  @override
  Future<void> removeFromCart(String itemId) async {
    try {
      _cartItems.removeWhere((item) => item.id == itemId);
    } catch (e) {
      throw Exception('Failed to remove item from cart: $e');
    }
  }

  @override
  Future<void> updateCartItemQuantity(String itemId, int quantity) async {
    try {
      final index = _cartItems.indexWhere((item) => item.id == itemId);
      if (index != -1) {
        if (quantity <= 0) {
          // Remove item if quantity is 0 or less
          _cartItems.removeAt(index);
        } else {
          // Update quantity
          final item = _cartItems[index];
          _cartItems[index] = item.copyWith(quantity: quantity);
        }
      }
    } catch (e) {
      throw Exception('Failed to update cart item quantity: $e');
    }
  }

  @override
  Future<void> clearCart() async {
    try {
      _cartItems.clear();
    } catch (e) {
      throw Exception('Failed to clear cart: $e');
    }
  }

  @override
  Future<double> getCartTotal() async {
    try {
      final items = await getCartItems();
      return items.fold<double>(0.0, (sum, item) => sum + item.totalPrice);
    } catch (e) {
      throw Exception('Failed to get cart total: $e');
    }
  }
}

