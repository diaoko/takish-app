
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket/features/main/presentation/cubits/delete_ticket_cubit.dart';

import '../main_button.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({
    super.key,
    required this.title,
    required this.text,
    required this.onOkTap,
});

  final String title;
  final String text;
  final VoidCallback onOkTap;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Positioned(
            left: 20,
            right: 20,
            child: Center(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsetsDirectional.only(bottom: 16),
                height: 60,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color(0xFF0069F7),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    topLeft: Radius.circular(16),
                  ),
                ),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'IranSans',
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width*1.0,
            padding: const EdgeInsets.only(
              top: 16,
              bottom: 16,
            ),
            margin: const EdgeInsets.only(top: 45),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white
            ),
            child: BlocConsumer<DeleteTicketCubit, List<int?>> (
              listener: (context, state) {
                Navigator.pop(context);
              },
              builder: (context, state) {
                return IntrinsicHeight(
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          text,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'IranSans',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 4, end: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: MainButton(
                                text: 'انصراف',
                                onTap: () => Navigator.pop(context),
                                color: Colors.white,
                                textColor: Colors.black,
                              ),
                            ),
                            Expanded(
                              child: MainButton(
                                text: 'بله',
                                onTap: onOkTap,
                                color: const Color(0xFF0069F7),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}