import 'package:equatable/equatable.dart';

class Coffee extends Equatable {
  final int id;
  final String imagePath;
  final String name;
  final String type;
  final double price;
  final double rating;
  final String description;

  const Coffee({
    required this.id,
    required this.imagePath,
    required this.name,
    required this.type,
    required this.price,
    required this.rating,
    required this.description,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    imagePath,
    price,
    description,
    type,
    rating,
  ];
}
