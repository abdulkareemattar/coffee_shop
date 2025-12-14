import 'package:json_annotation/json_annotation.dart';

part 'product_response.g.dart';

@JsonSerializable()
class ProductResponse {
  final String id;
  final String name;
  final String description;
  final double price;
  final String image;
  final String categoryId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ProductResponse({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.categoryId,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductResponseToJson(this);
}

@JsonSerializable()
class CreateProductRequest {
  final String name;
  final String description;
  final double price;
  final String image;
  final String categoryId;

  CreateProductRequest({
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.categoryId,
  });

  factory CreateProductRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateProductRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateProductRequestToJson(this);
}
