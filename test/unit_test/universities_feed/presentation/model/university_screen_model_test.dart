import 'package:flutter_test/flutter_test.dart';
import 'package:rxdart_state_management_article/features/universities_feed/domain/entity/university.dart';
import 'package:rxdart_state_management_article/features/universities_feed/presentation/models/university_screen_model.dart';

void main() {
  University universityOne = University(
    alphaCode: "US",
    country: "United States",
    state: "",
    name: "Marywood University",
    websites: ["http://www.marywood.edu"],
    domains: ["marywood.edu"],
  );

  University universityTwo = University(
    alphaCode: "US",
    country: "United States",
    state: "",
    name: "Lindenwood University",
    websites: ["http://www.lindenwood.edu/"],
    domains: ["lindenwood.edu"],
  );
  UniversityScreenModel expectedUniversityScreenModelOne =
      UniversityScreenModel(
    country: "United States",
    name: "Marywood University",
    website: "http://www.marywood.edu",
  );

  UniversityScreenModel expectedUniversityScreenModelTwo =
      UniversityScreenModel(
    country: "United States",
    name: "Lindenwood University",
    website: "http://www.lindenwood.edu/",
  );

  group("Test UniversityScreenModel fromDomain", () {
    test('Test fromDomain using universityOne', () {
      expect(UniversityScreenModel.fromDomain(universityOne),
          expectedUniversityScreenModelOne);
    });
    test('Test fromDomain using universityTwo', () {
      expect(UniversityScreenModel.fromDomain(universityTwo),
          expectedUniversityScreenModelTwo);
    });
  });
}
