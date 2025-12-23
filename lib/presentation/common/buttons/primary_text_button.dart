import 'package:flutter/material.dart';
import 'package:coffee_shop/core/utils/app_colors.dart';

/// A reusable text button with primary color styling
/// Used for navigation links and secondary actions throughout the app
class PrimaryTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool bold;
  final Color? textColor;

  const PrimaryTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.bold = true,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: textColor ?? AppColors.primary,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          fontFamily: 'Sora',
        ),
      ),
    );
  }
}
