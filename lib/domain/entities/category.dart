import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String name;
  final String? image;
  final String? description;

  const Category({
    required this.id,
    required this.name,
    this.image,
    this.description,
  });

  @override
  List<Object?> get props => [id, name, image, description];

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json['id'],
    name: json['name'],
    image: json['image'],
    description: json['description'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image': image,
    'description': description,
  };
}
