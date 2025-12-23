import 'package:dio/dio.dart';

class DataErrorHandler {
  static String handle(dynamic error) {
    if (error is DioException) {
      return _handleDioError(error);
    } else if (error is Exception) {
      final message = error.toString();
      if (message.startsWith('Exception: ')) {
        return message.substring(11);
      }
      return message;
    } else {
      return 'An unexpected error occurred. Please try again.';
    }
  }

  static String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timed out. Please check your internet and try again.';
      case DioExceptionType.badResponse:
        return _handleBadResponse(error.response);
      case DioExceptionType.cancel:
        return 'Request was cancelled.';
      case DioExceptionType.connectionError:
        return 'Unable to connect to the server. Please check your internet.';
      case DioExceptionType.unknown:
        if (error.message?.contains('SocketException') ?? false) {
          return 'No internet connection. Please connect and try again.';
        }
        return 'Something went wrong. Please try again later.';
      default:
        return 'A network error occurred (${error.type}).';
    }
  }

  static String _handleBadResponse(Response? response) {
    if (response == null) return 'Server currently unavailable.';

    final statusCode = response.statusCode;
    final data = response.data;

    // Try to extract message from server response
    if (data is Map && data.containsKey('message')) {
      return data['message'].toString();
    }
    if (data is Map && data.containsKey('error')) {
      return data['error'].toString();
    }

    switch (statusCode) {
      case 400:
        return 'Bad request. Please check your input.';
      case 401:
        return 'Unauthorized. Please login again.';
      case 403:
        return 'Access denied.';
      case 404:
        return 'Requested resource not found.';
      case 500:
        return 'Internal server error. Our team is working on it.';
      case 503:
        return 'Server is under maintenance. Please try again later.';
      default:
        return 'Error $statusCode: Something went wrong.';
    }
  }
}
