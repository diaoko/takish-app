import 'package:flutter_bloc/flutter_bloc.dart';

part 'show_password_state.dart';

class ShowPasswordCubit extends Cubit<ShowPasswordState> {
  ShowPasswordCubit() : super(ShowPasswordState(true));

  void togglePasswordVisibility() {
    emit(ShowPasswordState(!state.obscureText));
  }
}
