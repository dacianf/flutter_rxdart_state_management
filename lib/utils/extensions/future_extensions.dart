import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart_state_management_article/network_config/app_result.dart';

extension FutureExtension<T> on Future<T> {
  Stream<AppResult<T>> safeApi() {
    return then((value) {
      return AppResult.data(value);
    })
        .onError((error, stackTrace) {
          if (error is DioError) {
            return AppResult.apiError(error.error);
          }
          return AppResult.appError(error.toString());
        })
        .asStream()
        .startWith(const AppResult.loading());
  }

  Stream<AppResult<E>> safeApiConvert<E>(E Function(T) transform) {
    return then((value) {
      return AppResult.data(transform(value));
    })
        .onError((error, stackTrace) {
          if (error is DioError) {
            return AppResult.apiError(error.error);
          }
          return AppResult.appError(error.toString());
        })
        .asStream()
        .startWith(const AppResult.loading());
  }
}
