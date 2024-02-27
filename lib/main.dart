
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:ticket/core/constants/storage_constants.dart';
import 'package:ticket/core/routes/pages.dart';
import 'package:ticket/core/routes/routes.dart';
import 'package:ticket/cubit/bloc/invalidate_order/invalidate_order_bloc.dart';
import 'package:ticket/features/main/presentation/cubits/delete_ticket_cubit.dart';
import 'package:ticket/features/main/presentation/cubits/ticket_selected_list_cubit.dart';
import 'package:ticket/features/scanner/data/model/ticket_item_model.dart';
import 'package:ticket/features/scanner/data/model/ticket_model.dart';
import 'package:ticket/features/scanner/presentation/bloc/scan_bloc.dart';
import 'package:ticket/locator.dart';

import 'core/services/navigation_service.dart';
import 'features/login/presentation/bloc/auth_bloc.dart';
import 'features/login/presentation/bloc/auth_event.dart';
import 'features/login/presentation/cubit/remember_me_cubit.dart';
import 'features/main/presentation/cubits/ticket_active_multi_select_cubit.dart';
import 'features/main/presentation/cubits/ticket_long_press_cubit.dart';
import 'features/main/presentation/cubits/ticket_select_all_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  //* Hive
  await Hive.initFlutter();
  Hive.registerAdapter(TicketItemModelAdapter());

  await Hive.openBox<dynamic>(HiveBoxes.settingsBox);
  await Hive.openBox<dynamic>(HiveBoxes.currentUserBox);
  await Hive.openBox<TicketItemModel>(HiveBoxes.ticketBox);

  //* Service Locator
  setupLocator();

  await SentryFlutter.init(
      (options) {
        options.dsn = 'https://04d5a85959f485c8dcc54ec0fb50b25f@o4506772480327680.ingest.sentry.io/4506772482097152';
        options.tracesSampleRate = 1.0;
      },
      appRunner: () => runApp(
        MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ScanBloc()),
            BlocProvider(create: (context) => DeleteTicketCubit()),
            BlocProvider(
              create: (context) => AuthBloc()..add(AppStartedEvent()),
            ),
            BlocProvider(
              create: (context) => RememberMeCubit(
                currentUserBox: Hive.box<dynamic>(HiveBoxes.currentUserBox),
              ),
            ),
            BlocProvider(create: (context) => InvalidateOrderBloc()),

            BlocProvider(create: (context) => TicketLongPressCubit()..toggle(false),),
            BlocProvider(create: (context) => TicketActiveMultiSelectCubit()..toggle(false),),
            BlocProvider(create: (context) => TicketSelectAllCubit()..toggle(false),),
            BlocProvider(create: (context) => TicketSelectedListCubit(),),
          ],
          child: EasyLocalization(
            supportedLocales: const [
              Locale('fa'),
            ],
            fallbackLocale: const Locale('fa'),
            path: 'assets/translations',
            startLocale: const Locale('fa'),
            child: const MyApp(),
          ),
        ),
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var currentUserBox = Hive.box<dynamic>(HiveBoxes.currentUserBox);
    String userToken = currentUserBox.get(HiveKeys.token, defaultValue: '');

    return MaterialApp(
      title: 'تاکیش 724',
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService.navigatorKey,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      initialRoute: (userToken.isNotEmpty && !userToken.contains('null')) ? AppRoutes.mainPage : AppRoutes.initialPage,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(primary: Color(0xff90d0e7)),
      ),
      routes: AppPages.pages,
    );
  }
}
