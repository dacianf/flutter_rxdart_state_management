import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rxdart_state_management_article/utils/extensions/map_extensions.dart';

part 'api_error.g.dart';

@JsonSerializable()
class ApiError extends Error {
  int statusCode;
  String message;
  Map<String, dynamic>? errors;

  ApiError({
    required this.statusCode,
    required this.message,
    this.errors,
  }) : super();

  factory ApiError.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorFromJson(json);

  ApiError copyWith({
    int? statusCode,
    String? message,
    Map<String, dynamic>? errors,
  }) {
    return ApiError(
      statusCode: statusCode ?? this.statusCode,
      message: message ?? this.message,
      errors: errors ?? this.errors,
    );
  }

  @override
  String toString() {
    return 'ApiError{statusCode: $statusCode, message: $message, errors: $errors}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ApiError &&
          runtimeType == other.runtimeType &&
          statusCode == other.statusCode &&
          message == other.message &&
          (errors?.hasSameElementsAs(other.errors) ?? errors == other.errors);

  @override
  int get hashCode => statusCode.hashCode ^ message.hashCode;
}
