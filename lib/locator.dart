
import 'package:get_it/get_it.dart';
import 'package:ticket/core/services/hive_service.dart';
import 'package:ticket/features/ticket_detail/data/repository/invalidate_order_item_repository.dart';

import 'core/services/dio_service.dart';
import 'core/services/internet_connection_service.dart';
import 'features/login/data/repository/login_repository.dart';

final locator = GetIt.instance;

void setupLocator() {
  /// Services
  locator.registerSingleton<HiveService>(HiveService());
  locator.registerSingleton<DioService>(DioService());
  locator.registerSingleton<InternetConnectionService>(
      InternetConnectionService());

  //* Remote Repositories
  locator.registerSingleton<LoginRepository>(LoginRepository());
  locator.registerSingleton<InvalidateOrderItemRepository>(InvalidateOrderItemRepository());
}