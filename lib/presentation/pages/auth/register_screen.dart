import 'package:coffee_shop/presentation/manager/cubit/auth/auth_cubit.dart';
import 'package:coffee_shop/presentation/manager/cubit/theme/theme_cubit.dart';
import 'package:coffee_shop/presentation/pages/auth/widgets/auth_footer.dart';
import 'package:coffee_shop/presentation/pages/auth/widgets/auth_header.dart';
import 'package:coffee_shop/presentation/pages/auth/widgets/register_form.dart';
import 'package:coffee_shop/presentation/common/buttons/primary_button.dart';
import 'package:coffee_shop/presentation/common/snackbar/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: Container(
        height: 1.sh,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: context.authGradient,
          ),
        ),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            state.maybeWhen(
              authenticated: (_) {
                CustomSnackBar.showSuccess(
                  context,
                  message: 'Registration Successful! Please Login.',
                );
                context.go('/login');
              },
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
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AuthHeader(
                        title: 'Create Account',
                        subtitle: 'Sign up to get started',
                        showLogo: true,
                        isDark: isDark,
                      ),
                      SizedBox(height: 32.h),
                      RegisterForm(
                        firstNameController: _firstNameController,
                        lastNameController: _lastNameController,
                        emailController: _emailController,
                        phoneController: _phoneController,
                        passwordController: _passwordController,
                        formKey: _formKey,
                        isDark: isDark,
                      ),
                      SizedBox(height: 32.h),
                      PrimaryButton(
                        text: 'Register',
                        isLoading: isLoading,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthCubit>().register(
                              _firstNameController.text,
                              _lastNameController.text,
                              _emailController.text,
                              _passwordController.text,
                              _phoneController.text,
                            );
                          }
                        },
                      ),
                      SizedBox(height: 24.h),
                      AuthFooter(
                        text: "Already have an account?",
                        actionText: 'Login',
                        onActionPressed: () => context.pop(),
                        isDark: isDark,
                      ),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
