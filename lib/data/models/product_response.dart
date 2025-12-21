import 'package:json_annotation/json_annotation.dart';

part 'product_response.g.dart';

// Custom converter for price (handles both String and num)
class PriceConverter implements JsonConverter<double, dynamic> {
  const PriceConverter();

  @override
  double fromJson(dynamic json) {
    if (json is num) {
      return json.toDouble();
    } else if (json is String) {
      return double.tryParse(json) ?? 0.0;
    }
    return 0.0;
  }

  @override
  dynamic toJson(double object) => object;
}

@JsonSerializable()
class ProductResponse {
  final String id;
  final String name;
  final String description;

  @PriceConverter()
  final double price;

  final String image;
  final String categoryId;
  final double? rating;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ProductResponse({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.categoryId,
    this.rating,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductResponseToJson(this);
}

@JsonSerializable()
class ProductsListResponse {
  final List<ProductResponse> products;
  final int total;
  final int page;
  final int limit;

  ProductsListResponse({
    required this.products,
    required this.total,
    required this.page,
    required this.limit,
  });

  factory ProductsListResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductsListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsListResponseToJson(this);
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
