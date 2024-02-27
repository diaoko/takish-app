import 'dart:ffi';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';
import 'package:ticket/core/constants/storage_constants.dart';
import 'package:ticket/core/utils/enums/ticket_status.dart';
import 'package:ticket/features/scanner/data/model/ticket_item_model.dart';
import 'package:ticket/features/scanner/data/model/ticket_model.dart';

class HiveService {
  final Logger logger = Logger();

  List<TicketItemModel> getTickets() {
    logger.w('Get Tickets');

    try {
      var ticketBox = Hive.box<TicketItemModel>(HiveBoxes.ticketBox);
      logger.w('ticket box ------->  ${ticketBox.length}');
      var ii = ticketBox.values.toList();
      return ticketBox.values.toList();
    } catch(e) {
      return List.empty();
    }
  }

  void addTicket({required TicketItemModel ticket}) {
    logger.w('Add Ticket');

    try {
      var ticketBox = Hive.box<TicketItemModel>(HiveBoxes.ticketBox);
      ticketBox.add(ticket);
    } catch(e) {
      logger.e(e.toString());
    }
  }

  List<int?> deleteTicket({required List<int> ticketIds}) {
    logger.w('Delete Ticket ID: ${ticketIds.length}');

    try {
      var ticketBox = Hive.box<TicketItemModel>(HiveBoxes.ticketBox);

      logger.w('${ticketBox.values.length}');

      // ticketBox.values.toList().removeWhere((element) => ticketIds.contains(element.id));
      //
      // return true;

      for(int i = 0; i < ticketBox.length; i++) {
        for (var id in ticketIds) {
          if(ticketBox.values.elementAt(i).id == id) {
            ticketBox.deleteAt(i);
          }
        }
      }
      return ticketIds;
    } catch (e) {
      logger.e(e.toString());
      return List.empty();
    }
  }

  Future<void> invalidTicket({required List<int> ticketIds}) async {
    logger.w('Delete Ticket ID: ${ticketIds.length}');

    try {
      var ticketBox = Hive.box<TicketItemModel>(HiveBoxes.ticketBox);

      logger.w('${ticketBox.values.length}');

      for(int i = 0; i < ticketBox.length; i++) {
        for (var id in ticketIds) {
          if(ticketBox.values.elementAt(i).id == id) {
            // ticketBox.deleteAt(i);
            ticketBox.values.elementAt(i).status = TicketStatus.invalid.value;
            await ticketBox.putAt(i, ticketBox.values.elementAt(i));
          }
        }
      }
    } catch (e) {
      logger.e(e.toString());
    }
  }

  String getUserToken() {
    var currentUserBox = Hive.box<dynamic>(HiveBoxes.currentUserBox);
    String userToken = currentUserBox.get(HiveKeys.token);

    return userToken;
  }

  String getSecretKey() {
    var currentUserBox = Hive.box<dynamic>(HiveBoxes.currentUserBox);
    String secretKey = currentUserBox.get(HiveKeys.secretKey);

    return secretKey;
  }
}