
import 'package:ticket/core/constants/server_url.dart';

class ApiUrls {
  static String baseUrl = ServerUrl.getServerUrl();

  static String login = "${ServerUrl.getServerUrl()}/SP/Account/SPLogin";
  static String invalidateItems = "${ServerUrl.getServerUrl()}/SP/OrderItems/InvalidateItems";
}
