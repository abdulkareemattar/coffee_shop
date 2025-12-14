import 'package:json_annotation/json_annotation.dart';

part 'category_response.g.dart';

@JsonSerializable()
class CategoryResponse {
  final String id;
  final String name;
  final String description;
  final bool isActive;
  final int? productCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CategoryResponse({
    required this.id,
    required this.name,
    required this.description,
    required this.isActive,
    this.productCount,
    this.createdAt,
    this.updatedAt,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryResponseToJson(this);
}
