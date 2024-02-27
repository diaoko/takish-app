import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logger/logger.dart';

class InternetConnectionService {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? connectivityStreamSubscription;

  Future<bool> isInternetConnected() async {
    var result = await _connectivity.checkConnectivity();
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      Logger().w('Internet is Connected.');
      return true;
    }
    Logger().w('Internet is Disconnected.');
    return false;
  }
}
