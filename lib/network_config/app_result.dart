import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rxdart_state_management_article/network_config/api_error.dart';

part 'app_result.freezed.dart';

@freezed
class AppResult<T> with _$AppResult {
  const AppResult._();

  const factory AppResult.data(T value) = Data;

  const factory AppResult.loading() = Loading;

  const factory AppResult.appError([String? message]) = AppError;

  const factory AppResult.apiError(ApiError error) = AppResultApiError;

  AppResult<E> safeMap<E>(E Function(T) transform) {
    return when(
      data: (e) => AppResult<E>.data(transform(e)),
      loading: () => const AppResult.loading(),
      appError: (e) => AppResult<E>.appError(e),
      apiError: (e) => AppResult<E>.apiError(e),
    );
  }
}
