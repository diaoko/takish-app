import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../../../../core/constants/api_urls.dart';
import '../../../../core/constants/server_url.dart';
import '../../../../core/services/dio_service.dart';
import '../../../../locator.dart';
import '../models/login_model.dart';

class LoginRepository {
  static final _logger = Logger();

  //* login user
  Future<LoginModel?> login(
      String userName,
      String password,
      ) async {
    try {
      final dioService = locator<DioService>();

      FormData data = FormData.fromMap({
        'UserName': userName,
        'Password': password,
        'Role': '1',
      });

      var response = await dioService.postMethod(
        url: ApiUrls.login,
        data: data,
      );

      print(ApiUrls.login);
      if (response == null) {
        return null;
      } else {
        if (response.statusCode == 200) {
          return LoginModel.fromJson(response.data);
        } else {
          return null;
        }
      }
    } catch (e) {
      _logger.e(e);
      print(e);
      return null;
    }
  }
}
