import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:toastification/toastification.dart';

import '../../../../core/constants/api_urls.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/services/dio_service.dart';
import '../../../../core/services/hive_service.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../../locator.dart';

class InvalidateOrderItemRepository {
  static final _logger = Logger();

  Future<List<int>?> invalidateOrderItem({required List<int> orderIds}) async {
    try {
      final dioService = locator<DioService>();
      final hiveService = locator<HiveService>();

      Map<String, dynamic> data = <String, dynamic>{};

      data['items'] = jsonEncode(orderIds);

      var response = await dioService.postMethod(
        url: ApiUrls.invalidateItems,
        headers: {HttpHeaders.authorizationHeader: 'Bearer ${hiveService.getUserToken()}'},
        data: {
          'items': orderIds
        },
      );

      if (response == null) {
        return null;
      } else {
        if (response.statusCode == 200) {
          List<dynamic> responseData = response.data;
          return responseData.map((element) => element as int).toList();
        } else {
          if (response.statusCode == 401) {
            toastification.show(
              context: NavigationService.navigatorKey.currentContext!,
              title: 'دوباره لاگین کنید...',
              type: ToastificationType.info,
              autoCloseDuration: const Duration(milliseconds: 3000),
              // description: 'description',
            );
            Navigator.pushReplacementNamed(NavigationService.navigatorKey.currentContext!, AppRoutes.loginPage);
          }
          return List.empty();
        }
      }
    } catch (e) {
      _logger.e(e);
      return null;
    }
  }
}
