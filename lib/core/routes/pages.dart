import 'package:ticket/core/routes/routes.dart';
import 'package:ticket/features/main/presentation/main_page.dart';
import 'package:ticket/features/scanner/presentation/scanner_page.dart';
import 'package:ticket/features/ticket_detail/presentation/ticket_detail_page.dart';

import '../../features/login/presentation/login_page.dart';

class AppPages {
  AppPages._();

  static final pages = {
    AppRoutes.loginPage: (context) => const LoginPage(),
    AppRoutes.mainPage: (context) => const MainPage(),
    AppRoutes.scannerPage: (context) => ScannerPage(),
    AppRoutes.ticketDetailPage: (context) => const TicketDetailPage(),
  };
}
