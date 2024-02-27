part of 'scan_bloc.dart';

@immutable
abstract class ScanState {}

class ScanInitialState extends ScanState {}

class ScanCompleteState extends ScanState {
  final TicketItemModel ticket;

  ScanCompleteState({required this.ticket});
}

class ScanDuplicateState extends ScanState {
  final String message;

  ScanDuplicateState({required this.message});
}

class ScanErrorState extends ScanState {
  final String message;

  ScanErrorState({required this.message});
}

class ScanReloadState extends ScanState {}