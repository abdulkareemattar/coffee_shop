class ApiConstants {
  // Base URL
  static const String baseUrl = 'https://coffee-shop-jqa5.onrender.com';

  // API Version
  static const String apiVersion = '/api/v1';

  // Timeout
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Auth Endpoints
  static const String register = '/api/user/auth/register';
  static const String login = '/api/user/auth/login';

  // User Endpoints
  static const String users = '/api/user';
  static const String currentUser = '/api/user/current-user';
  static String userById(String id) => '/api/user/$id';
  static const String updateMe = '/api/user/update-user/me';
  static String updateUser(String id) => '/api/user/update-user/$id';
  static String deleteUser(String id) => '/api/user/update-user/$id';

  // Product Endpoints
  static const String products = '$apiVersion/products';
  static String productById(String id) => '$apiVersion/products/$id';
  static String productsByCategory(String categoryId) =>
      '$apiVersion/products/category/$categoryId';

  // Category Endpoints
  static const String categories = '$apiVersion/categories';
  static String categoryById(String id) => '$apiVersion/categories/$id';
  static const String categoriesWithCount = '$apiVersion/categories/with-count';

  // Review Endpoints
  static const String reviews = '$apiVersion/reviews';
  static String reviewById(String id) => '$apiVersion/reviews/$id';

  // Address Endpoints
  static const String addresses = '$apiVersion/addresses';
  static String addressById(String id) => '$apiVersion/addresses/$id';

  // Headers
  static const String contentType = 'application/json';
  static const String accept = 'application/json';
}
