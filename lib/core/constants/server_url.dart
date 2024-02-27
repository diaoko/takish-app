import 'package:hive_flutter/hive_flutter.dart';
import 'package:ticket/core/constants/storage_constants.dart';

class ServerUrl {
  ServerUrl._();

  static String getServerUrl() {
    return Hive.box(HiveBoxes.settingsBox)
        .get(HiveKeys.ipAddress, defaultValue: 'https://api.test.takish724.ir/api');
  }
}