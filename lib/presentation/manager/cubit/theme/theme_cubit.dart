import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ThemeCubit extends HydratedCubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  void toggleTheme() {
    if (state == ThemeMode.dark) {
      emit(ThemeMode.light);
    } else if (state == ThemeMode.light) {
      emit(ThemeMode.dark);
    } else {
      // If system, toggle based on current brightness
      final brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      emit(brightness == Brightness.dark ? ThemeMode.light : ThemeMode.dark);
    }
  }

  void setLightTheme() => emit(ThemeMode.light);
  void setDarkTheme() => emit(ThemeMode.dark);
  void setSystemTheme() => emit(ThemeMode.system);

  @override
  ThemeMode? fromJson(Map<String, dynamic> json) {
    try {
      return ThemeMode.values[json['themeMode'] as int];
    } catch (_) {
      return ThemeMode.system;
    }
  }

  @override
  Map<String, dynamic>? toJson(ThemeMode state) {
    return {'themeMode': state.index};
  }
}

/// Helper extension to access theme properties easily from context
extension ThemeHelper on BuildContext {
  bool get isDarkMode {
    final themeMode = watch<ThemeCubit>().state;
    if (themeMode == ThemeMode.system) {
      return MediaQuery.of(this).platformBrightness == Brightness.dark;
    }
    return themeMode == ThemeMode.dark;
  }

  ThemeData get theme => Theme.of(this);
  Color get primaryColor => theme.primaryColor;
  Color get scaffoldBackgroundColor => theme.scaffoldBackgroundColor;

  List<Color> get authGradient {
    if (isDarkMode) {
      return [
        const Color(0xFF1C1C1C),
        const Color(0xFF321E14),
        const Color(0xFF23150D),
      ];
    } else {
      return [
        Colors.white,
        const Color.fromARGB(255, 255, 176, 123), // Very light cream
        const Color.fromARGB(255, 171, 103, 62), // Soft latte touch
      ];
    }
  }
}
