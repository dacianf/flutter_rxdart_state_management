import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart_state_management_article/features/universities_feed/domain/entity/university.dart';
import 'package:rxdart_state_management_article/features/universities_feed/domain/repository/untiversities_repository.dart';
import 'package:rxdart_state_management_article/features/universities_feed/domain/usecase/get_universities_by_country_use_case.dart';
import 'package:rxdart_state_management_article/features/universities_feed/presentation/models/university_screen_model.dart';
import 'package:rxdart_state_management_article/features/universities_feed/presentation/models/university_screen_state.dart';
import 'package:rxdart_state_management_article/network_config/app_result.dart';

import 'get_universities_by_country_use_case_test.mocks.dart';

@GenerateMocks([UniversitiesRepository])
void main() {
  late UniversitiesRepository repository;
  late GetUniversitiesByCountryUseCase useCase;

  List<University> universities = [
    University(
      alphaCode: "US",
      country: "United States",
      state: "",
      name: "Marywood University",
      websites: ["http://www.marywood.edu"],
      domains: ["marywood.edu"],
    ),
    University(
      alphaCode: "US",
      country: "United States",
      state: "",
      name: "Lindenwood University",
      websites: ["http://www.lindenwood.edu/"],
      domains: ["lindenwood.edu"],
    ),
  ];
  UniversityScreenState expectedScreenState =
      UniversityScreenState(universities: [
    UniversityScreenModel(
        country: "United States",
        name: "Marywood University",
        website: "http://www.marywood.edu"),
    UniversityScreenModel(
        country: "United States",
        name: "Lindenwood University",
        website: "http://www.lindenwood.edu/")
  ]);

  group("Test function calls", () {
    setUp(() {
      repository = MockUniversitiesRepository();
      useCase =
          GetUniversitiesByCountryUseCase(universitiesRepository: repository);
    });

    test('Test useCase calls getUniversities from repository', () {
      when(repository.getUniversities("test")).thenAnswer((realInvocation) =>
          Stream.value(const AppResult.data(<University>[])));

      useCase.invoke("test");
      verify(repository.getUniversities("test"));
    });

    test(
        'Test useCase maps getUniversities response to UniversityScreenState with empty list',
        () {
      when(repository.getUniversities("test")).thenAnswer((realInvocation) =>
          Stream.value(const AppResult.data(<University>[])));

      expect(
        useCase.invoke("test"),
        emitsInOrder([
          AppResult<UniversityScreenState>.data(
              UniversityScreenState(universities: []))
        ]),
      );
    });

    test(
        'Test useCase maps getUniversities response to UniversityScreenState with items in list',
        () {
      when(repository.getUniversities("test")).thenAnswer(
          (realInvocation) => Stream.value(AppResult.data(universities)));

      expect(
        useCase.invoke("test"),
        emitsInOrder(
            [AppResult<UniversityScreenState>.data(expectedScreenState)]),
      );
    });

    test(
        'Test useCase gets all app result state events on stream and maps them successfully',
        () {
      when(repository.getUniversities("test"))
          .thenAnswer((realInvocation) => Stream.fromIterable([
                const AppResult<Never>.loading(),
                const AppResult<List<University>>.appError("Error"),
                const AppResult<List<University>>.data(<University>[]),
              ]));

      expect(
        useCase.invoke("test"),
        emitsInOrder([
          const AppResult<Never>.loading(),
          const AppResult<UniversityScreenState>.appError("Error"),
          AppResult<UniversityScreenState>.data(
              UniversityScreenState(universities: []))
        ]),
      );
    });
  });
}
