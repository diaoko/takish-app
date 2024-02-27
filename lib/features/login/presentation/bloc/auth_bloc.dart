import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';

import '../../../../core/constants/storage_constants.dart';
import '../../../../core/services/internet_connection_service.dart';
import '../../../../locator.dart';
import '../../data/repository/login_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _loginRepository = locator<LoginRepository>();
  final _internetConnectionService = locator<InternetConnectionService>();
  final _logger = Logger();

  AuthBloc() : super(LoginInitialState()) {
    on<AppStartedEvent>(_appStartedEvent);
    on<LoginEvent>(_loginEvent);
    on<LogoutEvent>(_logoutEvent);
  }

  _appStartedEvent(AppStartedEvent event, Emitter<AuthState> emit) async {
    try {
      var currentUserBox = Hive.box<dynamic>(HiveBoxes.currentUserBox);
      var username = currentUserBox.get(HiveKeys.username, defaultValue: '');
      var password = currentUserBox.get(HiveKeys.password, defaultValue: '');
      var isRememberMe =
          currentUserBox.get(HiveKeys.isRememberMe, defaultValue: true);

      emit(LoginStartingState(
        username: username,
        password: password,
        isRememberMe: isRememberMe,
      ));
    } catch (e) {
      _logger.e(e.toString());
      emit(AuthErrorState('خطایی رخ داده...'));
    }
  }

  _loginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthenticatingState());

    try {
      if (await _internetConnectionService.isInternetConnected()) {
        final login = await _loginRepository.login(
          event.username,
          event.password
        );

        if(login == null) {
          emit(AuthErrorState('خطایی رخ داده...'));
        }
        else {
          var currentUserBox =
          Hive.box<dynamic>(HiveBoxes.currentUserBox);
          //* clear the previous data in Box.
          await currentUserBox.clear();

          if (event.isRememberMe) {
            currentUserBox.put(HiveKeys.username, event.username);
            currentUserBox.put(HiveKeys.password, event.password);
          }
          currentUserBox.put(HiveKeys.token, login.token);
          currentUserBox.put(HiveKeys.secretKey, login.secretKey);
          currentUserBox.put(HiveKeys.isRememberMe, event.isRememberMe);
          emit(AuthenticatedState(loginModel: login));
        }
      } else {
        emit(AuthErrorState('اینترنت خود را بررسی کنید...'));
        return;
      }
    } catch (e) {
      _logger.e(e.toString());
      emit(AuthErrorState('خطایی رخ داده...'));
    }
  }

  _logoutEvent(LogoutEvent event, Emitter<AuthState> emit) {}
}
