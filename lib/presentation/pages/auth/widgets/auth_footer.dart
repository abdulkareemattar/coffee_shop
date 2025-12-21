import 'package:flutter/material.dart';
import 'package:coffee_shop/presentation/common/buttons/primary_text_button.dart';

class AuthFooter extends StatelessWidget {
  final String text;
  final String actionText;
  final VoidCallback onActionPressed;

  const AuthFooter({
    super.key,
    required this.text,
    required this.actionText,
    required this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text),
        PrimaryTextButton(text: actionText, onPressed: onActionPressed),
      ],
    );
  }
}
