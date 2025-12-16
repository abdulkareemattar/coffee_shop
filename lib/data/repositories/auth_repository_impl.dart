import 'package:injectable/injectable.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/remote/auth_api_client.dart';
import '../models/auth_request.dart';
import '../models/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthApiClient _authApiClient;
  final FlutterSecureStorage _secureStorage;

  AuthRepositoryImpl(this._authApiClient, this._secureStorage);

  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await _authApiClient.login(
        LoginRequest(email: email, password: password),
      );

      if (response.token != null) {
        await _secureStorage.write(key: 'auth_token', value: response.token);
      }

      return UserModel(
        id: response.user?.id ?? '',
        firstName: response.user?.firstName ?? '',
        lastName: response.user?.lastName ?? '',
        email: response.user?.email ?? email,
        role: response.user?.role ?? 'client',
        token: response.token,
      );
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  @override
  Future<User> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _authApiClient.register(
        RegisterRequest(
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
          role: 'client',
        ),
      );

      if (response.token != null) {
        await _secureStorage.write(key: 'auth_token', value: response.token);
      }

      return UserModel(
        id: response.user?.id ?? '',
        firstName: response.user?.firstName ?? firstName,
        lastName: response.user?.lastName ?? lastName,
        email: response.user?.email ?? email,
        role: response.user?.role ?? 'client',
        token: response.token,
      );
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  @override
  Future<void> logout() async {
    await _secureStorage.delete(key: 'auth_token');
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await _secureStorage.read(key: 'auth_token');
    return token != null && token.isNotEmpty;
  }

  @override
  Future<User?> getCurrentUser() async {
    final token = await _secureStorage.read(key: 'auth_token');
    if (token == null) return null;

    // In a real app, you would fetch user data from API using the token
    // For now, return null as we don't have a getCurrentUser endpoint
    return null;
  }
}

