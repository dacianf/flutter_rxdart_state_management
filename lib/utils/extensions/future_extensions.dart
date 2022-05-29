import 'package:rxdart/rxdart.dart';
import 'package:rxdart_state_management_article/network_config/api_error.dart';
import 'package:rxdart_state_management_article/network_config/app_result.dart';

extension FutureExtension<T> on Future<T> {
  Stream<AppResult<T>> safeApi() {
    return then((value) {
      return AppResult.data(value);
    })
        .onError((error, stackTrace) {
          if (error is ApiError) {
            return AppResult<T>.apiError(error);
          }
          return AppResult<T>.appError(error.toString());
        })
        .asStream()
        .startWith(AppResult<T>.loading());
  }

  Stream<AppResult<E>> safeApiConvert<E>(E Function(T) transform) {
    return then((value) {
      return AppResult<E>.data(transform(value));
    })
        .onError((error, stackTrace) {
          if (error is ApiError) {
            return AppResult<E>.apiError(error);
          }
          return AppResult<E>.appError(error.toString());
        })
        .asStream()
        .startWith(AppResult<E>.loading());
  }
}
