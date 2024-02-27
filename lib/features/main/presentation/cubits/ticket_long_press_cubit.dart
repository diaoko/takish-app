import 'package:flutter_bloc/flutter_bloc.dart';

class TicketLongPressCubit extends Cubit<bool> {

  TicketLongPressCubit() : super(false);

  void toggle(bool status) {
    emit(status);
  }
}