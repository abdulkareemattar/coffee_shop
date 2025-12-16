import 'package:equatable/equatable.dart';
import 'cart_item.dart';

enum OrderStatus {
  pending,
  confirmed,
  preparing,
  ready,
  delivered,
  cancelled,
}

class Order extends Equatable {
  final String id;
  final String userId;
  final List<CartItem> items;
  final double totalAmount;
  final OrderStatus status;
  final String? deliveryAddress;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? paymentMethod;
  final String? notes;

  const Order({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalAmount,
    required this.status,
    this.deliveryAddress,
    required this.createdAt,
    this.updatedAt,
    this.paymentMethod,
    this.notes,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        items,
        totalAmount,
        status,
        deliveryAddress,
        createdAt,
        updatedAt,
        paymentMethod,
        notes,
      ];
}

