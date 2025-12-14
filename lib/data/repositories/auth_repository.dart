import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import '../datasources/remote/auth_api_client.dart';
import '../models/auth_request.dart';

@lazySingleton
class AuthRepository {
  final AuthApiClient _authApiClient;
  final FlutterSecureStorage _secureStorage;

  AuthRepository(this._authApiClient, this._secureStorage);

  Future<AuthResponse> login(String email, String password) async {
    try {
      final response = await _authApiClient.login(
        LoginRequest(email: email, password: password),
      );

      // Save token if login successful
      if (response.token != null) {
        await _secureStorage.write(key: 'auth_token', value: response.token);
      }

      return response;
    } catch (e) {
      print('Login error: $e');
      rethrow;
    }
  }

  Future<AuthResponse> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    String role = 'client',
  }) async {
    try {
      final response = await _authApiClient.register(
        RegisterRequest(
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
          role: role,
        ),
      );

      // Save token if registration successful
      if (response.token != null) {
        await _secureStorage.write(key: 'auth_token', value: response.token);
      }

      return response;
    } catch (e) {
      print('Registration error: $e');
      rethrow;
    }
  }

  Future<void> logout() async {
    await _secureStorage.delete(key: 'auth_token');
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key: 'auth_token');
  }

  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}
