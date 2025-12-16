import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../../../../domain/entities/user.dart';
import '../../../../../domain/usecases/login_usecase.dart';
import '../../../../../domain/usecases/register_usecase.dart';
import '../../../../../domain/usecases/logout_usecase.dart';
import '../../../../../domain/usecases/check_auth_status_usecase.dart';
import '../../../../../data/models/auth_request.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';
part 'auth_cubit.g.dart';

@injectable
class AuthCubit extends HydratedCubit<AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final LogoutUseCase _logoutUseCase;
  final CheckAuthStatusUseCase _checkAuthStatusUseCase;

  AuthCubit(
    this._loginUseCase,
    this._registerUseCase,
    this._logoutUseCase,
    this._checkAuthStatusUseCase,
  ) : super(const AuthState.initial());

  Future<void> login(String email, String password) async {
    emit(const AuthState.loading());
    try {
      final user = await _loginUseCase(email, password);
      emit(AuthState.authenticated(_userToAuthResponse(user)));
    } catch (e) {
      emit(AuthState.failure(e.toString()));
    }
  }

  Future<void> register(
    String name,
    String email,
    String password,
    String phone,
  ) async {
    emit(const AuthState.loading());
    try {
      final nameParts = name.split(' ');
      final firstName = nameParts.isNotEmpty ? nameParts.first : name;
      final lastName = nameParts.length > 1
          ? nameParts.sublist(1).join(' ')
          : '';

      final user = await _registerUseCase(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
      );
      emit(AuthState.authenticated(_userToAuthResponse(user)));
    } catch (e) {
      emit(AuthState.failure(e.toString()));
    }
  }

  Future<void> logout() async {
    await _logoutUseCase();
    emit(const AuthState.unauthenticated());
  }

  Future<void> checkAuthStatus() async {
    final isLoggedIn = await _checkAuthStatusUseCase();
    if (isLoggedIn) {
      // Ideally we should fetch user profile here, but for now we just assume authenticated
    } else {
      emit(const AuthState.unauthenticated());
    }
  }

  // Helper to convert User to AuthResponse for backward compatibility
  AuthResponse _userToAuthResponse(User user) {
    return AuthResponse(
      token: user.token,
      user: UserData(
        id: user.id,
        firstName: user.firstName,
        lastName: user.lastName,
        email: user.email,
        role: user.role,
      ),
    );
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    // The fromJson method is generated in auth_cubit.freezed.dart
    // We need to use the generated function directly
    try {
      return _$AuthStateFromJson(json);
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return state.toJson();
  }
}
