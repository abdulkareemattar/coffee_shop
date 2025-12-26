import 'dart:async';
import 'package:coffee_shop/presentation/pages/home/home_screen.dart';
import 'package:coffee_shop/presentation/pages/notification/notification_screen.dart';
import 'package:coffee_shop/presentation/pages/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import '../../data/models/coffee_model.dart';
import '../../presentation/manager/cubit/auth/auth_cubit.dart';
import '../../presentation/pages/auth/login_screen.dart';
import '../../presentation/pages/auth/register_screen.dart';
import '../../presentation/pages/cart/cart_screen.dart';
import '../../presentation/pages/coffee/coffee_screen.dart';
import '../../presentation/pages/details/details_screen.dart';
import '../../presentation/pages/favorites/favorites_screen.dart';
import 'package:coffee_shop/presentation/pages/order/order_screen.dart';
import 'package:coffee_shop/presentation/pages/splash/animated_splash_screen.dart';
import 'package:coffee_shop/presentation/pages/tracking/tracking_screen.dart';
import 'package:coffee_shop/presentation/pages/admin/dashboard/admin_dashboard_screen.dart';
import 'package:coffee_shop/presentation/pages/admin/products/admin_products_screen.dart';
import 'package:coffee_shop/presentation/pages/admin/categories/admin_categories_screen.dart';

@lazySingleton
class AppRouter {
  final AuthCubit _authCubit;

  AppRouter(this._authCubit);

  GoRouter get router => _router;

  late final GoRouter _router = GoRouter(
    initialLocation: '/splash',
    debugLogDiagnostics: true,
    refreshListenable: _AuthRefreshNotifier(_authCubit),
    redirect: (context, state) {
      final authState = _authCubit.state;

      final userRole = authState.maybeWhen(
        authenticated: (response) => response.user?.role ?? 'client',
        orElse: () => 'client',
      );

      final isAuthenticated = authState.maybeWhen(
        authenticated: (_) => true,
        orElse: () => false,
      );

      final isOnboardingPage = state.uri.path == '/onboarding';
      final isLoginPage = state.uri.path == '/login';
      final isRegisterPage = state.uri.path == '/register';
      final isAuthPage = isLoginPage || isRegisterPage;
      final isAdminPage = state.uri.path.startsWith('/admin');

      // 1. Unauthenticated users trying to access protected pages (including admin)
      if (!isAuthenticated &&
          !isAuthPage &&
          !isOnboardingPage &&
          state.uri.path != '/splash') {
        return '/login';
      }

      // 2. Authenticated users trying to access auth pages (login/register)
      if (isAuthenticated && isAuthPage) {
        return userRole == 'admin' ? '/admin' : '/home';
      }

      // 3. Security: Prevent non-admin users from accessing admin pages
      if (isAuthenticated && isAdminPage && userRole != 'admin') {
        return '/home';
      }

      // 4. Case where authenticated user is at root / or splash
      if (isAuthenticated &&
          (state.uri.path == '/' || state.uri.path == '/splash')) {
        return userRole == 'admin' ? '/admin' : '/home';
      }

      return null; // No redirect needed
    },
    routes: [
      // Splash
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const AnimatedSplashScreen(),
      ),
      // Onboarding
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => OnboardingScreen(),
      ),

      // Login
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),

      // Register
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),

      // Home
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),

      // Coffee List
      GoRoute(
        path: '/coffee',
        name: 'coffee',
        builder: (context, state) => const CoffeePage(),
      ),

      // Coffee Details
      GoRoute(
        path: '/details',
        name: 'details',
        builder: (context, state) {
          final coffee = state.extra as CoffeeModel;
          return DetailsScreen(coffeeModel: coffee);
        },
      ),

      // Favorites
      GoRoute(
        path: '/favorites',
        name: 'favorites',
        builder: (context, state) => const FavoritesScreen(),
      ),

      // Cart
      GoRoute(
        path: '/cart',
        name: 'cart',
        builder: (context, state) => const CartScreen(),
      ),

      // Notifications
      GoRoute(
        path: '/notifications',
        name: 'notifications',
        builder: (context, state) => const NotificationScreen(),
      ),

      // Order
      GoRoute(
        path: '/order',
        name: 'order',
        builder: (context, state) {
          final coffee = state.extra as CoffeeModel;
          return OrderScreen(coffee: coffee);
        },
      ),

      // Tracking
      GoRoute(
        path: '/tracking',
        name: 'tracking',
        builder: (context, state) => const TrackingScreen(),
      ),

      // Admin Routes
      GoRoute(
        path: '/admin',
        name: 'admin_dashboard',
        builder: (context, state) => const AdminDashboardScreen(),
        routes: [
          GoRoute(
            path: 'products',
            name: 'admin_products',
            builder: (context, state) => const AdminProductsScreen(),
          ),
          GoRoute(
            path: 'categories',
            name: 'admin_categories',
            builder: (context, state) => const AdminCategoriesScreen(),
          ),
        ],
      ),
    ],

    // Error handling
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Page not found: ${state.uri}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/home'),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
}

// Route names for easy access
class Routes {
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String coffee = '/coffee';
  static const String details = '/details';
  static const String favorites = '/favorites';
  static const String cart = '/cart';
  static const String notifications = '/notifications';
  static const String order = '/order';
  static const String tracking = '/tracking';
}

// Helper class to listen to AuthCubit state changes
class _AuthRefreshNotifier extends ChangeNotifier {
  final AuthCubit _authCubit;
  late final StreamSubscription _subscription;

  _AuthRefreshNotifier(this._authCubit) {
    _subscription = _authCubit.stream.listen((_) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
