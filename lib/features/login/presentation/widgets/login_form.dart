import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../../../../core/routes/routes.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';
import 'login_button.dart';
import 'password_text_field.dart';
import 'remember_me_checkbox.dart';
import 'username_text_field.dart';

class LoginForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.usernameController,
    required this.passwordController,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    var theme = Theme.of(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthenticatingState) {
              isLoading = true;
            }
            else if (state is AuthenticatedState) {
              Navigator.pushReplacementNamed(context, AppRoutes.mainPage);
              toastification.show(
                context: context,
                title: 'ورود موفقیت آمیز...',
                type: ToastificationType.info,
                autoCloseDuration: const Duration(milliseconds: 3000),
              );
            }
            else if (state is AuthErrorState) {
              isLoading = false;
            }
          },
        ),
      ],
      child: SizedBox(
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // const SizedBox(height: 24),
            //* logo
            // Image.asset(
            //   'assets/images/logo.png',
            //   height: 120,
            //   width: 120,
            // ),
            // const SizedBox(height: 60),
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                ),
              ),
              height: size.height*0.8,
              // margin: const EdgeInsetsDirectional.only(top: 30),
              padding: const EdgeInsetsDirectional.only(start: 31, end: 31, top: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //* username
                  UsernameTextField(
                      usernameController: widget.usernameController),

                  const SizedBox(height: 25),

                  //* password
                  PasswordField(
                      passwordController: widget.passwordController),

                  const SizedBox(height: 28),

                  //* Remember me
                  const RememberMeCheckbox(),
                  const SizedBox(height: 33),
                  //* login button
                  LoginButton(
                    formKey: widget.formKey,
                    usernameController: widget.usernameController,
                    passwordController: widget.passwordController,
                    isLoading: isLoading,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
