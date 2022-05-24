import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rxdart_state_management_article/features/universities_feed/domain/entity/university.dart';

part 'university_screen_model.freezed.dart';

@freezed
class UniversityScreenModel with _$UniversityScreenModel {
  const UniversityScreenModel._();

  factory UniversityScreenModel({
    required String country,
    required String name,
    required String website,
  }) = _UniversityScreenModel;

  factory UniversityScreenModel.fromDomain(University university) {
    return UniversityScreenModel(
      country: university.country,
      name: university.name,
      website: university.websites.first,
    );
  }
}
