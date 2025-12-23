import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../../../core/error/data_error_handler.dart';
import '../../../../../domain/entities/user.dart';
import '../../../../../domain/usecases/login_usecase.dart';
import '../../../../../domain/usecases/register_usecase.dart';
import '../../../../../domain/usecases/logout_usecase.dart';
import '../../../../../domain/usecases/check_auth_status_usecase.dart';
import '../../../../../domain/usecases/get_current_user_usecase.dart';
import '../../../../../data/models/auth_request.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';
part 'auth_cubit.g.dart';

@lazySingleton
class AuthCubit extends HydratedCubit<AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final LogoutUseCase _logoutUseCase;
  final CheckAuthStatusUseCase _checkAuthStatusUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;

  AuthCubit(
    this._loginUseCase,
    this._registerUseCase,
    this._logoutUseCase,
    this._checkAuthStatusUseCase,
    this._getCurrentUserUseCase,
  ) : super(const AuthState.initial());

  // Call this method from the app initialization instead of constructor
  Future<void> initialize() async {
    await checkAuthStatus();
  }

  Future<void> login(String email, String password) async {
    // Check internet connection
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      emit(const AuthState.failure('No internet connection'));
      return;
    }

    emit(const AuthState.loading());
    try {
      final user = await _loginUseCase(email, password);
      emit(AuthState.authenticated(_userToAuthResponse(user)));
    } catch (e) {
      emit(AuthState.failure(_mapFailureToMessage(e)));
    }
  }

  Future<void> register(
    String firstName,
    String lastName,
    String email,
    String password,
    String phone,
  ) async {
    // Check internet connection
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      emit(const AuthState.failure('No internet connection'));
      return;
    }

    emit(const AuthState.loading());
    try {
      final user = await _registerUseCase(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
      );
      emit(AuthState.authenticated(_userToAuthResponse(user)));
    } catch (e) {
      emit(AuthState.failure(_mapFailureToMessage(e)));
    }
  }

  Future<void> logout() async {
    await _logoutUseCase();
    emit(const AuthState.unauthenticated());
  }

  Future<void> checkAuthStatus() async {
    // Don't emit loading state during initial auth check
    // This prevents buttons from showing loading state on app startup

    try {
      final isLoggedIn = await _checkAuthStatusUseCase();
      if (isLoggedIn) {
        // Check if we're already authenticated from HydratedBloc
        final isAlreadyAuthenticated = state.maybeWhen(
          authenticated: (_) => true,
          orElse: () => false,
        );

        // If already authenticated from HydratedBloc, keep that state
        if (isAlreadyAuthenticated) {
          return;
        }

        // Try to get current user
        final user = await _getCurrentUserUseCase();
        if (user != null) {
          emit(AuthState.authenticated(_userToAuthResponse(user)));
        } else {
          // If token exists but user data not available,
          // create a minimal authenticated state
          emit(
            AuthState.authenticated(
              AuthResponse(
                token: null, // Will be read from secure storage
                user: null,
              ),
            ),
          );
        }
      } else {
        // Token doesn't exist, ensure we're unauthenticated
        final currentState = state;
        final isAuthenticated = currentState.maybeWhen(
          authenticated: (_) => true,
          orElse: () => false,
        );

        if (isAuthenticated) {
          emit(const AuthState.unauthenticated());
        }
      }
    } catch (e) {
      // Only emit failure if we're not in initial state
      final isInitial = state.maybeWhen(
        initial: () => true,
        orElse: () => false,
      );

      if (!isInitial) {
        emit(AuthState.failure(_mapFailureToMessage(e)));
      }
    }
  }

  // Helper to provide user-friendly error messages
  String _mapFailureToMessage(Object error) {
    return DataErrorHandler.handle(error);
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
    try {
      final state = _$AuthStateFromJson(json);

      // Sanitize the restored state to ensure we never restore invalid states
      // like loading, failure, or initial. Restoring these states would cause
      // the UI to get stuck or show errors on startup.
      return state.maybeWhen(
        authenticated: (_) => state,
        unauthenticated: () => state,
        orElse: () =>
            const AuthState.unauthenticated(), // Default to safe unauthenticated state
      );
    } catch (e) {
      // On parsing error, fallback to safe unauthenticated state
      return const AuthState.unauthenticated();
    }
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    // Don't persist loading, failure, or initial states
    // Only persist authenticated and unauthenticated states
    return state.maybeWhen(
      authenticated: (_) => state.toJson(),
      unauthenticated: () => state.toJson(),
      orElse: () => null, // Don't save loading, failure, or initial states
    );
  }
}
