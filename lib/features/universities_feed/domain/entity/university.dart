import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'university.freezed.dart';

@freezed
class University with _$University {
  factory University({
    required String alphaCode,
    required String country,
    required String state,
    required String name,
    required List<String> websites,
    required List<String> domains,
  }) = _University;
}
