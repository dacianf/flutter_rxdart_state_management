import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rxdart_state_management_article/features/universities_feed/domain/entity/university.dart';

part 'api_university_model.freezed.dart';

part 'api_university_model.g.dart';

@freezed
class ApiUniversityModel with _$ApiUniversityModel {
  const ApiUniversityModel._();

  factory ApiUniversityModel({
    @JsonKey(name: "alpha_twi_code") String? alphaCode,
    @JsonKey(name: "country") String? country,
    @JsonKey(name: "state-province") String? state,
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "web_pages") List<String?>? websites,
    @JsonKey(name: "domains") List<String?>? domains,
  }) = _ApiUniversityModel;

  factory ApiUniversityModel.fromJson(Map<String, dynamic> json) =>
      _$ApiUniversityModelFromJson(json);

  University toDomain() {
    return University(
      alphaCode: alphaCode ?? "",
      country: country ?? "",
      state: state ?? "",
      name: name ?? "",
      websites: websites?.map((e) => e ?? "").toList() ?? [],
      domains: domains?.map((e) => e ?? "").toList() ?? [],
    );
  }
}
