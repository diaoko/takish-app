import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:toastification/toastification.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../cubit/remember_me_cubit.dart';

class LoginButton extends StatelessWidget {
  LoginButton({
    super.key,
    required this.formKey,
    required this.usernameController,
    required this.passwordController,
    required this.isLoading,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  bool isLoading;

  final ValueNotifier<String?> selectedPath = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthenticatingState) {}
          if (state is AuthErrorState) {
            toastification.show(
              context: context,
              title: state.errorMessage,
              type: ToastificationType.error,
              autoCloseDuration: const Duration(milliseconds: 3000),
            );
          }
        },
        builder: (context, state) {
          return SizedBox(
            height: 45,
            child: ElevatedButton(
              onPressed: () async {
                context.read<AuthBloc>().add(
                  LoginEvent(
                    username: usernameController.text,
                    password: passwordController.text,
                    isRememberMe:
                    context.read<RememberMeCubit>().state!,
                  ),
                );
              },
              style: ButtonStyle(
                //padding: MaterialStateProperty.all(const EdgeInsets.all(5)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                )),
                backgroundColor: MaterialStateProperty.all(const Color(0xFF061DDB)),
              ),
              child: (isLoading)
                  ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  strokeWidth: 3,
                  color: theme.buttonTheme.colorScheme!.primary,
                ),
              )
                  : const Text(
                'ورود',
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 1.5,
                  fontSize: 29,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'IranSans',
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
