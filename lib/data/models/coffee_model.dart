import '../../domain/entities/coffee.dart';

// The model has been updated to use 'imagePath' consistently.
class CoffeeModel extends Coffee {
  const CoffeeModel({
    required super.id,
    required super.imagePath,
    required super.name,
    required super.type,
    required super.price,
    required super.rating,
    required super.description,
  });

  // Convert a CoffeeModel into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imagePath':
          imagePath, // CORRECTED: Was 'image', now matches the database column.
      'price': price,
      'description': description,
    };
  }

  // Convert a Map into a CoffeeModel.
  factory CoffeeModel.fromMap(Map<String, dynamic> map) {
    return CoffeeModel(
      id: map['id'],
      name: map['name'],
      imagePath:
          map['imagePath'], // CORRECTED: Was 'image', now matches the database column.
      type: map['type'] ?? '',
      price: (map['price'] as num).toDouble(),
      rating: (map['rating'] as num?)?.toDouble() ?? 0.0,
      description: map['description'] ?? '',
    );
  }

  factory CoffeeModel.fromJson(Map<String, dynamic> json) =>
      CoffeeModel.fromMap(json);

  Map<String, dynamic> toJson() {
    final map = toMap();
    map['type'] = type;
    map['rating'] = rating;
    return map;
  }
}
