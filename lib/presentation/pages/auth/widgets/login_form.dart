import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:coffee_shop/presentation/common/buttons/primary_text_button.dart';
import 'custom_text_field.dart';

class LoginForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _isPasswordVisible = false;

  void _submitForm() {
    if (widget.formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus(); // Close keyboard
      // The parent widget handles the actual login logic through the button callback
      // We can also expose a specific callback for form submission if needed,
      // but for now relying on the parent's button logic is okay if we trigger it manually
      // However, since the parent holds the logic in the button's onPressed,
      // we need a way to trigger it.
      // Best practice refactor: The parent should pass a 'onLogin' callback that takes email/pass.
      // But adhering to current structure where parent reads controllers:
      // We just ensure validation passes here.
      // The "Done" action usually triggers the primary action.
      // We'll leave the actual "triggering" to the button for now to avoid refactoring the parent significantly yet,
      // OR we can make the parent pass a callback.
      // Let's stick to improving the UX *within* the form fields first.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            controller: widget.emailController,
            labelText: 'Email',
            hintText: 'Enter your email',
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.email],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              // Basic email validation regex
              final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
              if (!emailRegex.hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          SizedBox(height: 24.h),
          CustomTextField(
            controller: widget.passwordController,
            labelText: 'Password',
            hintText: 'Enter your password',
            prefixIcon: Icons.lock_outline,
            obscureText: !_isPasswordVisible,
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.password],
            onFieldSubmitted: (_) =>
                _submitForm(), // Validates and closes keyboard
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          SizedBox(height: 16.h),
          Align(
            alignment: Alignment.centerRight,
            child: PrimaryTextButton(
              text: 'Forgot Password?',
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
