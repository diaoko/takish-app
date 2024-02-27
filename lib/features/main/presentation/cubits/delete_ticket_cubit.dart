
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket/core/services/hive_service.dart';
import 'package:ticket/locator.dart';

class DeleteTicketCubit extends Cubit<List<int?>> {
  final hiveService = locator<HiveService>();

  DeleteTicketCubit() : super(List.empty());

  void onDeleteTicket(List<int> ticketIds) {
    try {
      var result = hiveService.deleteTicket(ticketIds: ticketIds);

      emit(result);
    } catch (e) {
      emit(List.empty());
    }
  }

  void invalidTickets(List<int> ticketIds) {
    try {
      var result = hiveService.invalidTicket(ticketIds: ticketIds);

      emit(List.empty());
    } catch (e) {
      emit(List.empty());
    }
  }
}