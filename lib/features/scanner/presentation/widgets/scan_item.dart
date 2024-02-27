import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ticket/features/main/presentation/widgets/ticket_item.dart';
import 'package:ticket/features/scanner/data/model/ticket_item_model.dart';

import '../../../../core/constants/storage_constants.dart';
import '../../../../core/services/hive_service.dart';
import '../../../../locator.dart';
import '../../data/model/ticket_model.dart';

class ScanItem extends StatelessWidget {
  final int ticketIndex;

  const ScanItem({super.key, required this.ticketIndex});

  @override
  Widget build(BuildContext context) {
    var hiveService = locator<HiveService>();

    var ticketBox = hiveService.getTickets();

    return Padding(
      padding: const EdgeInsetsDirectional.all(8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return Center(
                  child: TicketItem(ticket: ticketBox[ticketIndex]),
                );
              }
            );
          },
          child: Container(
            width: 70,
            height: 70,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: const Color(0xff3ea8be),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack (
              children: [
                const Column(
                  children: [
                    SizedBox(height: 5,),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(start: 5),
                        child: Divider(
                          thickness: 2,
                          color: Colors.white70,
                          endIndent: 50,
                          height: 10,
                        ),
                      ),
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(start: 5),
                        child: Divider(
                          thickness: 2,
                          color: Colors.white70,
                          endIndent: 40,
                          height: 15,
                        ),
                      ),
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(start: 5),
                        child: Divider(
                          thickness: 2,
                          color: Colors.white70,
                          endIndent: 35,
                          height: 15,
                        ),
                      ),
                    ),
                    Spacer(),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(start: 5),
                        child: Divider(
                          thickness: 2,
                          color: Colors.white70,
                          endIndent: 35,
                          height: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                Image.asset(
                  'assets/images/pool.png',
                  width: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}