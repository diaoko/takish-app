import 'package:flutter_bloc/flutter_bloc.dart';

class TicketSelectAllCubit extends Cubit<bool> {

  TicketSelectAllCubit() : super(false);

  void toggle(bool status) {
    emit(status);
  }
}