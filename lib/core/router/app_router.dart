import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import '../../data/models/coffee_model.dart';
import '../../presentation/pages/auth/login_screen.dart';
import '../../presentation/pages/auth/register_screen.dart';
import '../../presentation/pages/cart_screen.dart';
import '../../presentation/pages/coffee_screen.dart';
import '../../presentation/pages/details_screen.dart';
import '../../presentation/pages/favorites_screen.dart';
import '../../presentation/pages/home_screen.dart';
import '../../presentation/pages/notification_screen.dart';
import '../../presentation/pages/onboarding_screen.dart';
import '../../presentation/pages/order_screen.dart';
import '../../presentation/pages/tracking_screen.dart';

@lazySingleton
class AppRouter {
  GoRouter get router => _router;

  final GoRouter _router = GoRouter(
    initialLocation: '/onboarding',
    debugLogDiagnostics: true,
    routes: [
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
