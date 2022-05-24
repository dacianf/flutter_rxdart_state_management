import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:rxdart_state_management_article/network_config/error_convertor.dart';
import 'package:rxdart_state_management_article/utils/app_config.dart';

extension DioClientExtension on Dio {
  static Dio createUniversitiesApiClient({
    contentType = "application/json",
    bool shouldRefreshToken = true,
    ApiAuthorization authorizationType = ApiAuthorization.none,
  }) {
    Map<String, String> headers = {
      "Content-Type": contentType,
      "Accept": "application/json",
    };
    Dio dio = Dio(BaseOptions(
      baseUrl: AppConfig.universitiesApiUrl,
      headers: headers,
      connectTimeout: 10000,
      receiveTimeout: 15000,
      sendTimeout: 15000,
    ));
    dio.interceptors.addAll([
      LogInterceptor(
          responseBody: true,
          requestBody: true,
          logPrint: (text) {
            if (!AppConfig.isProduction) {
              Logger.root.log(Level.INFO, "${DateTime.now()}: $text");
            }
          }),
      ErrorConverter(),
    ]);
    return dio;
  }
}

enum ApiAuthorization { none, basic, token }
