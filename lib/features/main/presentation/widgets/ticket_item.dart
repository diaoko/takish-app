import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:ticket/core/utils/enums/ticket_status.dart';
import 'package:ticket/core/utils/extensions/datetime_format_extension.dart';
import 'package:ticket/features/main/presentation/cubits/delete_ticket_cubit.dart';
import 'package:ticket/features/scanner/data/model/ticket_item_model.dart';
import 'package:ticket/features/scanner/data/model/ticket_model.dart';
import 'package:ticket/features/scanner/presentation/bloc/scan_bloc.dart';
import 'package:ticket/widgets/dialogs/app_dialog.dart';

import '../../../../core/routes/routes.dart';
import '../cubits/ticket_active_multi_select_cubit.dart';
import '../cubits/ticket_long_press_cubit.dart';
import '../cubits/ticket_select_all_cubit.dart';
import '../cubits/ticket_selected_list_cubit.dart';

class TicketItem extends StatelessWidget {
  final TicketItemModel ticket;

  const TicketItem({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return InkWell(
      onLongPress: () {
        context.read<TicketActiveMultiSelectCubit>().toggle(true);
        context.read<TicketLongPressCubit>().toggle(true);
        context.read<TicketSelectedListCubit>().addTicketId(ticket.id);
      },
      onTap: () {
        if (context.read<TicketActiveMultiSelectCubit>().state) {
          if (context.read<TicketLongPressCubit>().state) {
            context.read<TicketLongPressCubit>().toggle(false);
          }
          else {
            context.read<TicketLongPressCubit>().toggle(true);
            context.read<TicketSelectedListCubit>().addTicketId(ticket.id);
          }
        }
        else {
          Navigator.pushNamed(
            context,
            AppRoutes.ticketDetailPage,
            arguments: ticket,
          );
        }
      },
      child: MultiBlocListener(
        listeners: [
          BlocListener<TicketActiveMultiSelectCubit, bool>(
            listener: (context, isActiveMultiSelect) {
              if (!isActiveMultiSelect) {
                context.read<TicketLongPressCubit>().toggle(false);
              }
            },
          ),
          BlocListener<TicketSelectAllCubit, bool>(
            listener: (context, isSelectAll) {
              if (isSelectAll) {
                context.read<TicketLongPressCubit>().toggle(true);
                context.read<TicketSelectedListCubit>().addTicketId(ticket.id);
              }
              else {
                context.read<TicketLongPressCubit>().toggle(false);
              }
            },
          ),
        ],
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFFFFFFFF),
                border: Border.all(color: const Color(0xFF061DDB))
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.all(8),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Container(
                              padding: const EdgeInsetsDirectional.only(
                                  start: 30,
                                  end: 30,
                                  top: 3,
                                  bottom: 3
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xFF0069F7)
                              ),
                              child: const Text(
                                'بلیط تک نفره',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFFFFFF),
                                  fontFamily: 'IranSans',
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Divider(
                          height: 10,
                          thickness: 0.5,
                          color: Color(0xFF0069F7),
                        ),
                        // const SizedBox(height: 30,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              ticket.titlePackage,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF272C42),
                                fontFamily: 'IranSans',
                              ),
                            ),
                            BlocBuilder<TicketActiveMultiSelectCubit, bool>(
                              builder: (context, isActiveMultiSelect) {
                                return Visibility(
                                  visible: isActiveMultiSelect,
                                  child: Expanded(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: BlocBuilder<TicketLongPressCubit, bool> (
                                        builder: (context, isLongPress) {
                                          return Container(
                                            width: 23,
                                            height: 23,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: isLongPress ? const Color(0xFFFFFFFF) : const Color(0xFF0069F7)),
                                              shape: BoxShape.circle,
                                              color: isLongPress ? const Color(0xFF0069F7) : const Color(0xFFFFFFFF),
                                            ),
                                            child: const Center(
                                              child: Icon(
                                                Icons.check,
                                                color: Color(0xFFFFFFFF),
                                                size: 17,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'تاریخ: ',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0069F7),
                                fontFamily: 'IranSans',
                              ),
                            ),
                            Container(
                              padding: const EdgeInsetsDirectional.only(
                                  start: 15,
                                  end: 15,
                                  top: 3,
                                  bottom: 3
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: const Color.fromRGBO(237, 242, 244, 0.9)
                              ),
                              child: Text(
                                DateTime.parse(ticket.createDate).toJalali().toPersianDateTimeFormat().toPersianDigit(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF272C42),
                                  fontFamily: 'IranSans',
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'هزینه بلیط: ',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0069F7),
                                fontFamily: 'IranSans',
                              ),
                            ),
                            Container(
                              padding: const EdgeInsetsDirectional.only(
                                  start: 15,
                                  end: 15,
                                  top: 3,
                                  bottom: 3
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: const Color.fromRGBO(237, 242, 244, 0.9)
                              ),
                              child: Text(
                                double.parse(ticket.price).toInt().toString().toPersianDigit().seRagham(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF272C42),
                                  fontFamily: 'IranSans',
                                ),
                              ),
                            ),
                            BlocBuilder<TicketActiveMultiSelectCubit, bool>(
                              builder: (context, isActiveMultiSelect) {
                                return IgnorePointer(
                                  ignoring: isActiveMultiSelect,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: GestureDetector(
                                      onTap: () {
                                        Logger().w(context.read<TicketSelectedListCubit>().ids);
                                        showDialog(
                                            context: context,
                                            builder: (_) {
                                              return BlocProvider(create: (context) => DeleteTicketCubit(),
                                                child: BlocConsumer<DeleteTicketCubit, List<int?>>(
                                                  listener: (context, state) {
                                                    Logger().w('on Delete .......');
                                                    context.read<ScanBloc>().add(ReloadScanEvent());
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
                                      child: const Icon(
                                        Icons.delete_forever,
                                        color: Colors.black,
                                        size: 32,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: ticket.status == TicketStatus.invalid.value,
                  child: Container(
                    width: size.width,
                    padding: const EdgeInsetsDirectional.only(
                      top: 6,
                      bottom: 6,
                    ),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      color: Color(0xFF272C42),
                    ),
                    child: const Text(
                      'باطل شد',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFFFFF),
                        fontFamily: 'IranSans',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}