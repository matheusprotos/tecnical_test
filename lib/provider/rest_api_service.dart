import 'package:dio/dio.dart';

import '../constants/rest_api_constants.dart' as RestAPIConstants;

class RestAPIProvider {
  static RestAPIProvider instance;

  final Dio dio = Dio(BaseOptions(
    baseUrl: RestAPIConstants.BASE_URL,
  ));

  static get getInstance {
    if (instance == null) instance = RestAPIProvider();

    return instance;
  }

  Future<Response<dynamic>> getPolicies() => dio.get(RestAPIConstants.POLICIES);
}
