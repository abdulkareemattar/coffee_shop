// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Initial _$InitialFromJson(Map<String, dynamic> json) =>
    _Initial($type: json['runtimeType'] as String?);

Map<String, dynamic> _$InitialToJson(_Initial instance) => <String, dynamic>{
  'runtimeType': instance.$type,
};

_Loading _$LoadingFromJson(Map<String, dynamic> json) =>
    _Loading($type: json['runtimeType'] as String?);

Map<String, dynamic> _$LoadingToJson(_Loading instance) => <String, dynamic>{
  'runtimeType': instance.$type,
};

_Authenticated _$AuthenticatedFromJson(Map<String, dynamic> json) =>
    _Authenticated(
      AuthResponse.fromJson(json['response'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$AuthenticatedToJson(_Authenticated instance) =>
    <String, dynamic>{
      'response': instance.response,
      'runtimeType': instance.$type,
    };

_Unauthenticated _$UnauthenticatedFromJson(Map<String, dynamic> json) =>
    _Unauthenticated($type: json['runtimeType'] as String?);

Map<String, dynamic> _$UnauthenticatedToJson(_Unauthenticated instance) =>
    <String, dynamic>{'runtimeType': instance.$type};

_Failure _$FailureFromJson(Map<String, dynamic> json) =>
    _Failure(json['message'] as String, $type: json['runtimeType'] as String?);

Map<String, dynamic> _$FailureToJson(_Failure instance) => <String, dynamic>{
  'message': instance.message,
  'runtimeType': instance.$type,
};
