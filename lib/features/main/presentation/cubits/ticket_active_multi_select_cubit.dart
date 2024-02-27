import 'package:flutter_bloc/flutter_bloc.dart';

class TicketActiveMultiSelectCubit extends Cubit<bool> {

  TicketActiveMultiSelectCubit() : super(false);

  void toggle(bool status) {
    emit(status);
  }
}