part of 'scan_bloc.dart';

@immutable
abstract class ScanEvent {}

class ScanInitialEvent extends ScanEvent {}

class ValidScanEvent extends ScanEvent {
  final TicketItemModel ticket;

  ValidScanEvent({required this.ticket});
}

class InvalidScanEvent extends ScanEvent {
  final String message;

  InvalidScanEvent({required this.message});
}

class ReloadScanEvent extends ScanEvent {}