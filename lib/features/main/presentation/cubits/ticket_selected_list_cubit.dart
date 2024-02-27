import 'package:flutter_bloc/flutter_bloc.dart';

class TicketSelectedListCubit extends Cubit<List<int>> {
  TicketSelectedListCubit() : super(List.empty());

  List<int> ids = [];

  void addTicketId(int id) {
    ids.add(id);
  }
  void getTickets() {
    emit(ids);
  }

  void clearTickets() {
    ids.clear();
  }
}