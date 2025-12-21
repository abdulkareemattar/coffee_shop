import 'package:coffee_shop/presentation/manager/cubit/auth/auth_cubit.dart';
import 'package:coffee_shop/presentation/pages/auth/widgets/auth_footer.dart';
import 'package:coffee_shop/presentation/pages/auth/widgets/auth_header.dart';
import 'package:coffee_shop/presentation/pages/auth/widgets/login_form.dart';
import 'package:coffee_shop/presentation/common/buttons/primary_button.dart';
import 'package:coffee_shop/presentation/common/snackbar/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          state.maybeWhen(
            authenticated: (_) => context.go('/home'),
            failure: (message) =>
                CustomSnackBar.showError(context, message: message),
            orElse: () {},
          );
        },
        builder: (context, state) {
          final isLoading = state.maybeWhen(
            loading: () => true,
            orElse: () => false,
          );

          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AuthHeader(
                      title: 'Welcome Back!',
                      subtitle: 'Login to your account to continue',
                    ),
                    SizedBox(height: 32.h),
                    LoginForm(
                      emailController: _emailController,
                      passwordController: _passwordController,
                      formKey: _formKey,
                    ),
                    SizedBox(height: 24.h),
                    PrimaryButton(
                      text: 'Login',
                      isLoading: isLoading,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthCubit>().login(
                            _emailController.text,
                            _passwordController.text,
                          );
                        }
                      },
                    ),
                    SizedBox(height: 24.h),
                    AuthFooter(
                      text: "Don't have an account?",
                      actionText: 'Register',
                      onActionPressed: () => context.push('/register'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
