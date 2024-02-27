
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:ticket/core/utils/enums/ticket_status.dart';
import 'package:ticket/cubit/bloc/invalidate_order/invalidate_order_bloc.dart';
import 'package:ticket/features/ticket_detail/presentation/widgets/ticket_detail_item.dart';
import 'package:ticket/features/scanner/data/model/ticket_item_model.dart';
import 'dart:ui' as ui;

import 'package:ticket/widgets/submit_button.dart';

import '../../../widgets/dialogs/app_dialog.dart';
import '../../main/presentation/cubits/delete_ticket_cubit.dart';
import '../../main/presentation/cubits/ticket_active_multi_select_cubit.dart';
import '../../main/presentation/cubits/ticket_selected_list_cubit.dart';
import '../../scanner/presentation/bloc/scan_bloc.dart';

class TicketDetailPage extends StatelessWidget {
  const TicketDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TicketItemModel ticket = ModalRoute.of(context)!.settings.arguments as TicketItemModel;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DeleteTicketCubit()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<DeleteTicketCubit, List<int?>>(
            listener: (context, state) {
              context.read<ScanBloc>().add(ReloadScanEvent());
              Navigator.of(context).pop();
            },
          ),
          BlocListener<InvalidateOrderBloc, InvalidateOrderState>(
            listener: (context, state) {
              if (state is InvalidateOrderLoadedState) {
                context.read<DeleteTicketCubit>().invalidTickets(state.ids);
              }
            },
          ),
        ],
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(237, 242, 244, 0.9),
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(55),
            child: Directionality(
              textDirection: ui.TextDirection.ltr,
              child: AppBar(
                shadowColor: Colors.transparent,
                backgroundColor: const Color.fromRGBO(237, 242, 244, 0.9),
                title: const Text(
                  'جزئیات فاکتور',
                  style: TextStyle(
                    fontFamily: 'Modam',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                centerTitle: true,
                leading: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 40,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 5,
              end: 5,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SubmitButton(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return BlocProvider(create: (context) => DeleteTicketCubit(),
                              child: BlocConsumer<DeleteTicketCubit, List<int?>>(
                                listener: (context, state) {
                                  Logger().w('on Delete .......');
                                  context.read<ScanBloc>().add(ReloadScanEvent());
                                  context.read<TicketActiveMultiSelectCubit>().toggle(false);
                                  context.read<TicketSelectedListCubit>().clearTickets();

                                  Navigator.of(context).pop();
                                },
                                builder: (context, state) {
                                  return BlocBuilder<DeleteTicketCubit, List<int?>> (
                                    builder: (context, state) {
                                      return AppDialog(
                                        title: 'حذف بلیط',
                                        text: 'از حذف بلیط مطمئن هستید؟',
                                        onOkTap: () {
                                          context.read<DeleteTicketCubit>().onDeleteTicket([ticket.id]);
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                            );
                          }
                      );
                    },
                    isLoading: false,
                    text: 'حذف',
                    color: const Color(0xFFFF1A1A),
                  ),
                ),
                Visibility(
                  visible: ticket.status == TicketStatus.valid.value,
                  child: const SizedBox(width: 30,)
                ),
                Visibility(
                  visible: ticket.status == TicketStatus.valid.value,
                  child: Expanded(
                    child: BlocBuilder<InvalidateOrderBloc, InvalidateOrderState> (
                      builder: (context, state) {
                        return SubmitButton(
                          onTap: () {
                            context.read<InvalidateOrderBloc>().add(InvalidateOrderEvent(ids: [ticket.id]));
                          },
                          isLoading: state is InvalidateOrderLoadingState,
                          text: 'باطل',
                          color: const Color(0xFF0069F7),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: TicketDetailItem(ticket: ticket),
        ),
      ),
    );
  }

}