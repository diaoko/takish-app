import 'package:flutter/foundation.dart';

import '../../data/models/login_model.dart';

@immutable
abstract class AuthState {}

class LoginInitialState extends AuthState {}

class LoginStartingState extends AuthState {
  final String username;
  final String password;
  final bool isRememberMe;

  LoginStartingState({
    required this.username,
    required this.password,
    required this.isRememberMe,
  });
}

class AuthenticatingState extends AuthState {}

class AuthenticatedState extends AuthState {
  final LoginModel loginModel;

  AuthenticatedState({
    required this.loginModel,
  });
}

class AuthErrorState extends AuthState {
  final String errorMessage;
  AuthErrorState(this.errorMessage);
}
