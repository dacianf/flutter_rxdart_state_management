import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'json_api_response.freezed.dart';

part 'json_api_response.g.dart';

@freezed
class JsonApiResponse with _$JsonApiResponse {
  factory JsonApiResponse({required Map<String, dynamic> json}) =
      _JsonApiResponse;

  factory JsonApiResponse.fromJson(Map<String, dynamic> json) =>
      _$JsonApiResponseFromJson(json);
}
