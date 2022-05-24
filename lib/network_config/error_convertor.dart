import 'package:dio/dio.dart';
import 'package:rxdart_state_management_article/network_config/api_error.dart';

class ErrorConverter extends InterceptorsWrapper {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.type != DioErrorType.response) {
      handler.next(err);
      return;
    }
    Map<String, dynamic> errorBody = {
      "statusCode": -1,
      "message": "Something went wrong",
    };
    errorBody["statusCode"] = err.response?.statusCode;
    var error = err.response?.data;
    if (error is Map<String, dynamic>) {
      errorBody["message"] = error["error"];
    } else if (error is List && error.first is Map<String, dynamic>) {
      errorBody.addAll(error.first);
    }
    var apiError = ApiError.fromJson(errorBody);
    handler.next(err..error = apiError);
  }
}
