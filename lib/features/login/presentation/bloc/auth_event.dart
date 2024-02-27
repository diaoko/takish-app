import 'package:flutter/foundation.dart';

@immutable
abstract class AuthEvent {}

class AppStartedEvent extends AuthEvent {}

class SettingValueEvent extends AuthEvent {}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;
  final bool isRememberMe;

  LoginEvent({
    required this.username,
    required this.password,
    required this.isRememberMe,
  });
}

class LogoutEvent extends AuthEvent {}
