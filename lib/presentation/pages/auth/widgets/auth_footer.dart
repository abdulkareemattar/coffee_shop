import 'package:flutter/material.dart';
import 'package:coffee_shop/presentation/common/buttons/primary_text_button.dart';

class AuthFooter extends StatelessWidget {
  final String text;
  final String actionText;
  final VoidCallback onActionPressed;
  final bool isDark;

  const AuthFooter({
    super.key,
    required this.text,
    required this.actionText,
    required this.onActionPressed,
    this.isDark = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(
            color: isDark ? Colors.white.withOpacity(0.8) : Colors.black87,
            fontFamily: 'Sora',
          ),
        ),
        PrimaryTextButton(
          text: actionText,
          onPressed: onActionPressed,
          textColor: isDark ? Colors.white : null,
        ),
      ],
    );
  }
}
