// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductResponse _$ProductResponseFromJson(Map<String, dynamic> json) =>
    ProductResponse(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: const PriceConverter().fromJson(json['price']),
      image: json['image'] as String,
      categoryId: json['categoryId'] as String,
      rating: (json['rating'] as num?)?.toDouble(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ProductResponseToJson(ProductResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': const PriceConverter().toJson(instance.price),
      'image': instance.image,
      'categoryId': instance.categoryId,
      'rating': instance.rating,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

ProductsListResponse _$ProductsListResponseFromJson(
  Map<String, dynamic> json,
) => ProductsListResponse(
  products: (json['products'] as List<dynamic>)
      .map((e) => ProductResponse.fromJson(e as Map<String, dynamic>))
      .toList(),
  total: (json['total'] as num).toInt(),
  page: (json['page'] as num).toInt(),
  limit: (json['limit'] as num).toInt(),
);

Map<String, dynamic> _$ProductsListResponseToJson(
  ProductsListResponse instance,
) => <String, dynamic>{
  'products': instance.products,
  'total': instance.total,
  'page': instance.page,
  'limit': instance.limit,
};

CreateProductRequest _$CreateProductRequestFromJson(
  Map<String, dynamic> json,
) => CreateProductRequest(
  name: json['name'] as String,
  description: json['description'] as String,
  price: (json['price'] as num).toDouble(),
  image: json['image'] as String,
  categoryId: json['categoryId'] as String,
);

Map<String, dynamic> _$CreateProductRequestToJson(
  CreateProductRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
  'price': instance.price,
  'image': instance.image,
  'categoryId': instance.categoryId,
};
