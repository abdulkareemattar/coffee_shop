import 'package:equatable/equatable.dart';
import 'product.dart';

class CartItem extends Equatable {
  final String id;
  final Product product;
  final int quantity;
  final String? size;
  final List<String>? extras;

  const CartItem({
    required this.id,
    required this.product,
    required this.quantity,
    this.size,
    this.extras,
  });

  double get totalPrice => product.price * quantity;

  CartItem copyWith({
    String? id,
    Product? product,
    int? quantity,
    String? size,
    List<String>? extras,
  }) {
    return CartItem(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
      extras: extras ?? this.extras,
    );
  }

  @override
  List<Object?> get props => [id, product, quantity, size, extras];
}

