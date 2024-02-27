import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ticket/core/services/hive_service.dart';
import 'package:ticket/features/scanner/data/model/ticket_model.dart';
import 'package:ticket/locator.dart';

import '../../../../core/constants/storage_constants.dart';
import '../../data/model/ticket_item_model.dart';

part 'scan_event.dart';
part 'scan_state.dart';

class ScanBloc extends Bloc<ScanEvent, ScanState> {
  final hiveService = locator<HiveService>();

  bool get isEmpty => hiveService.getTickets().isEmpty;

  ScanBloc() : super(ScanInitialState()) {
    on<ValidScanEvent>(validScanEvent);
    on<ScanInitialEvent>(initialScanEvent);
    on<InvalidScanEvent>(invalidScanEvent);
    on<ReloadScanEvent>(reloadScanEvent);
  }

  initialScanEvent(ScanInitialEvent event, Emitter<ScanState> emit) async {
    emit(ScanInitialState());
  }

  validScanEvent(ValidScanEvent event, Emitter<ScanState> emit) async {
    try {
      bool isDuplicate = false;

      if(hiveService.getTickets().toList().isNotEmpty) {
        for(var ticket in hiveService.getTickets()) {
          if(ticket.id == event.ticket.id) {
            isDuplicate = true;
            break;
          }
        }
      }

      if(!isDuplicate) {
        hiveService.addTicket(ticket: event.ticket);
        emit(ScanCompleteState(ticket: event.ticket));
      }
      else {
        emit(ScanDuplicateState(message: 'این بلیط قبلا اسکن شده'));
      }
    } catch(e) {
      emit(ScanErrorState(message: 'بلیط معتیر نیست...'));
    }
  }

  invalidScanEvent(InvalidScanEvent event, Emitter<ScanState> emit) async {
    emit(ScanErrorState(message: event.message));
  }

  reloadScanEvent(ReloadScanEvent event, Emitter<ScanState> emit) async {
    emit(ScanReloadState());
  }
}