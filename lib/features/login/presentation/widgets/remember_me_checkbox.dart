import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/internet_connection_service.dart';
import '../../../../locator.dart';
import '../cubit/remember_me_cubit.dart';

class RememberMeCheckbox extends StatelessWidget {
  const RememberMeCheckbox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final internetConnectionService = locator<InternetConnectionService>();

    return BlocBuilder<RememberMeCubit, bool?>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () async {
            if (await internetConnectionService.isInternetConnected()) {
              context.read<RememberMeCubit>().toggle(!state!);
            }
          },
          child: Row(
            children: [
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(width: 1.5, color: const Color(0xFF0081B6)),
                ),
                child: Checkbox(
                  value: state,
                  onChanged: (value) async {
                    if (await internetConnectionService
                        .isInternetConnected()) {
                      context.read<RememberMeCubit>().toggle(value!);
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                  ),
                  checkColor: Colors.black,
                  activeColor: Colors.white,
                  side: const BorderSide(
                      color: Colors.yellow,
                  ),
                ),
              ),
              const SizedBox(width: 4,),
              Text(
                'من رو بخاطر بسپار',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: theme.textTheme.bodyLarge!.color,
                  fontFamily: 'IranSans',
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
