part of 'invalidate_order_bloc.dart';

@immutable
sealed class InvalidateOrderState {}

final class InvalidateOrderInitialState extends InvalidateOrderState {}

final class InvalidateOrderLoadingState extends InvalidateOrderState {}

final class InvalidateOrderLoadedState extends InvalidateOrderState {
  final List<int> ids;

  InvalidateOrderLoadedState({required this.ids});
}

final class InvalidateOrderErrorState extends InvalidateOrderState {
  final String errorMessage;

  InvalidateOrderErrorState(this.errorMessage);
}
