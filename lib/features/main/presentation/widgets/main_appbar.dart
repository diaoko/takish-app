import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket/features/main/presentation/cubits/ticket_active_multi_select_cubit.dart';

import '../cubits/ticket_select_all_cubit.dart';
import '../cubits/ticket_selected_list_cubit.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'تاکیش 724',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.black,
          fontFamily: 'IranSans',
        ),
      ),
      backgroundColor: const Color.fromRGBO(237, 242, 244, 0.9),
      centerTitle: true,
      // leading: BlocBuilder<TicketActiveMultiSelectCubit, bool>(
      //   builder: (context, isActiveMultiSelect) {
      //     return Visibility(
      //       visible: isActiveMultiSelect,
      //       child: Padding(
      //         padding: const EdgeInsetsDirectional.all(3),
      //         child: GestureDetector(
      //           onTap: () {
      //             context.read<TicketActiveMultiSelectCubit>().toggle(false);
      //             context.read<TicketSelectAllCubit>().toggle(false);
      //             context.read<TicketSelectedListCubit>().clearTickets();
      //           },
      //           child: Container(
      //             width: 45,
      //             height: 45,
      //             color: const Color.fromRGBO(237, 242, 244, 0.7),
      //             child: const Icon(
      //               Icons.close,
      //               size: 25,
      //               color: Colors.black,
      //             ),
      //           ),
      //         ),
      //       ),
      //     );
      //   },
      // ),
      // actions: [
      //   BlocBuilder<TicketActiveMultiSelectCubit, bool>(
      //     builder: (context, isActiveMultiSelect) {
      //       return Visibility(
      //         visible: isActiveMultiSelect,
      //         child: Padding(
      //           padding: const EdgeInsetsDirectional.all(3),
      //           child: GestureDetector(
      //             onTap: () {
      //               context.read<TicketSelectAllCubit>().toggle(true);
      //             },
      //             child: Container(
      //               width: 45,
      //               height: 45,
      //               color: const Color.fromRGBO(237, 242, 244, 0.7),
      //               child: const Icon(
      //                 Icons.checklist_rtl,
      //                 size: 25,
      //                 color: Colors.black,
      //               ),
      //             ),
      //           ),
      //         ),
      //       );
      //     },
      //   ),
      // ],
    );
  }
}