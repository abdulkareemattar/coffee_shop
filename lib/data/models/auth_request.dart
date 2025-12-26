import 'package:json_annotation/json_annotation.dart';

part 'auth_request.g.dart';

@JsonSerializable()
class LoginRequest {
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}

@JsonSerializable()
class RegisterRequest {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String role;

  RegisterRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.role,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}

@JsonSerializable()
class AuthResponse {
  @JsonKey(name: 'token', includeIfNull: false)
  final String? token;

  @JsonKey(name: 'user', includeIfNull: false)
  final UserData? user;

  final String? message;

  AuthResponse({this.token, this.user, this.message});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    // Manually handle alternative keys if standard ones are missing
    String? effectiveToken = json['token'] ?? json['accessToken'];
    UserData? effectiveUser;

    if (json['user'] != null) {
      effectiveUser = UserData.fromJson(json['user']);
    } else if (json['newUser'] != null) {
      effectiveUser = UserData.fromJson(json['newUser']);
    }

    return AuthResponse(
      token: effectiveToken,
      user: effectiveUser,
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}

@JsonSerializable()
class UserData {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String role;

  UserData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
