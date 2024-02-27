import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';
import 'package:ticket/features/main/presentation/cubits/ticket_long_press_cubit.dart';
import 'package:ticket/features/main/presentation/cubits/ticket_selected_list_cubit.dart';
import 'package:ticket/features/main/presentation/widgets/main_appbar.dart';
import 'package:ticket/features/main/presentation/widgets/ticket_item.dart';
import 'package:ticket/features/scanner/data/model/ticket_item_model.dart';
import 'package:ticket/features/scanner/presentation/bloc/scan_bloc.dart';
import 'package:ticket/widgets/search.dart';
import 'package:ticket/widgets/submit_button.dart';

import '../../../core/constants/storage_constants.dart';
import '../../../core/routes/routes.dart';
import '../../../core/services/hive_service.dart';
import '../../../cubit/bloc/invalidate_order/invalidate_order_bloc.dart';
import '../../../locator.dart';
import '../../../widgets/dialogs/app_dialog.dart';
import '../../scanner/data/model/ticket_model.dart';
import 'cubits/delete_ticket_cubit.dart';
import 'cubits/ticket_active_multi_select_cubit.dart';
import 'cubits/ticket_select_all_cubit.dart';
import 'widgets/drawer/main_drawer.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var hiveService = locator<HiveService>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DeleteTicketCubit()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<DeleteTicketCubit, List<int?>>(
            listener: (context, state) {
              context.read<ScanBloc>().add(ReloadScanEvent());
              context.read<TicketActiveMultiSelectCubit>().toggle(false);
              context.read<TicketSelectedListCubit>().clearTickets();
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
            resizeToAvoidBottomInset: false,
            backgroundColor: const Color.fromRGBO(237, 242, 244, 1),
            appBar: const MainAppBar(),
            drawer: const MainDrawer(),
            bottomNavigationBar: BlocBuilder<TicketActiveMultiSelectCubit, bool>(
              builder: (context, isActiveMultiSelect) {
                if (isActiveMultiSelect) {
                  return Container(
                    color: const Color.fromRGBO(237, 242, 244, 0.7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
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
                                      },
                                      builder: (context, state) {
                                        return BlocBuilder<DeleteTicketCubit, List<int?>> (
                                          builder: (context, state) {
                                            return AppDialog(
                                              title: 'حذف بلیط',
                                              text: 'از حذف بلیط مطمئن هستید؟',
                                              onOkTap: () {
                                                context.read<DeleteTicketCubit>().onDeleteTicket(context.read<TicketSelectedListCubit>().ids);
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
                          child: Container(
                            padding: const EdgeInsetsDirectional.all(5),
                            color: const Color.fromRGBO(237, 242, 244, 0.0),
                            child: const Icon(
                              Icons.delete_forever_sharp,
                              size: 36,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(width: 40,),
                        GestureDetector(
                          onTap: () {
                            context.read<InvalidateOrderBloc>().add(InvalidateOrderEvent(ids: context.read<TicketSelectedListCubit>().ids));
                          },
                          child: Container(
                            padding: const EdgeInsetsDirectional.all(5),
                            color: const Color.fromRGBO(237, 242, 244, 0.0),
                            child: const Icon(
                              Icons.inventory_outlined,
                              size: 34,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                else {
                  return SubmitButton(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.scannerPage,
                      );
                    },
                    isLoading: false,
                    text: 'اسکن بلیط',
                  );
                }
              },
            ),
            body: BlocBuilder<ScanBloc, ScanState>(
              builder: (context, state) {
                var ticketBox = hiveService.getTickets();
                Logger().w('Update Main Screen.........');
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    /// Search Bar
                    BlocBuilder<TicketActiveMultiSelectCubit, bool> (
                      builder: (context, isActiveMultiSelect) {
                        return Visibility(
                          visible: !isActiveMultiSelect,
                          child: const Padding(
                            padding: EdgeInsetsDirectional.only(start: 4, end: 4),
                            child: Search(),
                          ),
                        );
                      },
                    ),

                    BlocBuilder<TicketActiveMultiSelectCubit, bool> (
                      builder: (context, isActiveMultiSelect) {
                        return Visibility(
                          visible: isActiveMultiSelect,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.all(3),
                                child: GestureDetector(
                                  onTap: () {
                                    context.read<TicketActiveMultiSelectCubit>().toggle(false);
                                    context.read<TicketSelectAllCubit>().toggle(false);
                                    context.read<TicketSelectedListCubit>().clearTickets();
                                  },
                                  child: Container(
                                    width: 45,
                                    height: 45,
                                    color: const Color.fromRGBO(237, 242, 244, 0.7),
                                    child: const Icon(
                                      Icons.close,
                                      size: 25,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.all(3),
                                child: GestureDetector(
                                  onTap: () {
                                    context.read<TicketSelectAllCubit>().toggle(true);
                                  },
                                  child: Container(
                                    width: 45,
                                    height: 45,
                                    color: const Color.fromRGBO(237, 242, 244, 0.7),
                                    child: const Icon(
                                      Icons.checklist_rtl,
                                      size: 25,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    /// Ticket List
                    Expanded(
                      child: Container(
                        padding: const EdgeInsetsDirectional.only(top: 12),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          color: Color.fromRGBO(237, 242, 244, 0.9),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(start: 4, end: 4, bottom: 2),
                          child: Column(
                            children: [
                              if(context.read<ScanBloc>().isEmpty)...[
                                Expanded(
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/empty.svg',
                                          height: size.height * 0.25,
                                        ),
                                        const SizedBox(height: 32),
                                        const Text(
                                          'لیست خالی است',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                            color: Colors.black54,
                                            fontFamily: 'IranSans',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ]
                              else...[
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: ticketBox.map((ticket) {
                                          return BlocProvider(
                                            create: (context) => TicketLongPressCubit(),
                                            child: Padding(
                                              padding: const EdgeInsetsDirectional.only(
                                                bottom: 8,
                                              ),
                                              child: TicketItem(ticket: ticket),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            )
        ),
      ),
    );
  }
}
