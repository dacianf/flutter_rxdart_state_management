import 'package:flutter_test/flutter_test.dart';
import 'package:rxdart_state_management_article/features/universities_feed/data/source/network/model/api_university_model.dart';
import 'package:rxdart_state_management_article/features/universities_feed/domain/entity/university.dart';

void main() {
  Map<String, dynamic> apiUniversityOneAsJson = {
    "alpha_two_code": "US",
    "domains": ["marywood.edu"],
    "country": "United States",
    "state-province": null,
    "web_pages": ["http://www.marywood.edu"],
    "name": "Marywood University"
  };
  ApiUniversityModel expectedApiUniversityOne = ApiUniversityModel(
    alphaCode: "US",
    country: "United States",
    state: null,
    name: "Marywood University",
    websites: ["http://www.marywood.edu"],
    domains: ["marywood.edu"],
  );
  University expectedUniversityOne = University(
    alphaCode: "US",
    country: "United States",
    state: "",
    name: "Marywood University",
    websites: ["http://www.marywood.edu"],
    domains: ["marywood.edu"],
  );

  Map<String, dynamic> apiUniversityTwoAsJson = {
    "alpha_two_code": "US",
    "domains": ["lindenwood.edu"],
    "country": "United States",
    "state-province": "MJ",
    "web_pages": null,
    "name": "Lindenwood University"
  };
  ApiUniversityModel expectedApiUniversityTwo = ApiUniversityModel(
    alphaCode: "US",
    country: "United States",
    state: "MJ",
    name: "Lindenwood University",
    websites: null,
    domains: ["lindenwood.edu"],
  );
  University expectedUniversityTwo = University(
    alphaCode: "US",
    country: "United States",
    state: "MJ",
    name: "Lindenwood University",
    websites: [],
    domains: ["lindenwood.edu"],
  );

  group("Test ApiUniversityModel initialization from json", () {
    test('Test using json one', () {
      expect(ApiUniversityModel.fromJson(apiUniversityOneAsJson),
          expectedApiUniversityOne);
    });
    test('Test using json two', () {
      expect(ApiUniversityModel.fromJson(apiUniversityTwoAsJson),
          expectedApiUniversityTwo);
    });
  });

  group("Test ApiUniversityModel toDomain", () {
    test('Test toDomain using json one', () {
      expect(ApiUniversityModel.fromJson(apiUniversityOneAsJson).toDomain(),
          expectedUniversityOne);
    });
    test('Test toDomain using json two', () {
      expect(ApiUniversityModel.fromJson(apiUniversityTwoAsJson).toDomain(),
          expectedUniversityTwo);
    });
  });
}
