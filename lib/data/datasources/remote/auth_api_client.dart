import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../models/auth_request.dart';

part 'auth_api_client.g.dart';

@RestApi()
abstract class AuthApiClient {
  factory AuthApiClient(Dio dio, {String baseUrl}) = _AuthApiClient;

  @POST('/api/user/auth/login')
  Future<AuthResponse> login(@Body() LoginRequest request);

  @POST('/api/user/auth/register')
  Future<AuthResponse> register(@Body() RegisterRequest request);

  @GET('/api/user/current-user')
  Future<AuthResponse> getCurrentUser();
}
