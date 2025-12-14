import 'package:coffee_shop/app.dart';
import 'package:coffee_shop/core/di/injection.dart';
import 'package:flutter/material.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}
