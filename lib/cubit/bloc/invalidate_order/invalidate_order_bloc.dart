import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';
import 'package:ticket/features/ticket_detail/data/repository/invalidate_order_item_repository.dart';
import 'package:ticket/translations/locale_keys.g.dart';

import '../../../locator.dart';

part 'invalidate_order_event.dart';
part 'invalidate_order_state.dart';

class InvalidateOrderBloc
    extends Bloc<InvalidateOrderEvent, InvalidateOrderState> {
  final _invalidateOrderItemRepository = locator<InvalidateOrderItemRepository>();

  InvalidateOrderBloc() : super(InvalidateOrderInitialState()) {
    on<InvalidateOrderEvent>(_getInvalidateOrderEvent);
  }

  _getInvalidateOrderEvent(InvalidateOrderEvent event,
      Emitter<InvalidateOrderState> emit) async {
    emit(InvalidateOrderLoadingState());

    try {
      List<int>? ids =
      await _invalidateOrderItemRepository.invalidateOrderItem(orderIds: event.ids);

      if (ids == null) {
        emit(InvalidateOrderErrorState(
            "امکان ابطال بلیط نیست. \nاینترنت خود را بررسی کنید."));
      } else {
        emit(InvalidateOrderLoadedState(ids: ids));
      }
    } catch (e) {
      Logger().e(e);
      emit(InvalidateOrderErrorState('خطایی رخ داده...'));
    }
  }
}
