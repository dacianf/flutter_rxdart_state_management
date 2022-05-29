import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart_state_management_article/features/universities_feed/domain/usecase/get_universities_by_country_use_case.dart';
import 'package:rxdart_state_management_article/features/universities_feed/presentation/models/university_screen_model.dart';
import 'package:rxdart_state_management_article/features/universities_feed/presentation/models/university_screen_state.dart';
import 'package:rxdart_state_management_article/features/universities_feed/presentation/screen/universities_view_model.dart';
import 'package:rxdart_state_management_article/network_config/api_error.dart';
import 'package:rxdart_state_management_article/network_config/app_result.dart';

import 'universities_view_model_test.mocks.dart';

@GenerateMocks([GetUniversitiesByCountryUseCase])
void main() {
  late GetUniversitiesByCountryUseCase useCase;
  late UniversitiesViewModel viewModel;

  UniversityScreenState universityScreenState =
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
      useCase = MockGetUniversitiesByCountryUseCase();
      viewModel =
          UniversitiesViewModel(getUniversitiesByCountryUseCase: useCase);
    });

    test(
        'Test viewModel calls GetUniversitiesByCountryUseCase when stream universities is subscribed',
        () async {
      when(useCase.invoke(null))
          .thenAnswer((realInvocation) => Stream.fromIterable([
                AppResult.data(UniversityScreenState(universities: [])),
              ]));

      await viewModel.universities.take(1).toList();
      verify(useCase.invoke(null));
    });

    test(
        'Test viewModel calls GetUniversitiesByCountryUseCase when stream universities is subscribed and gets loading and data',
        () {
      when(useCase.invoke(null))
          .thenAnswer((realInvocation) => Stream.fromIterable([
                const AppResult.loading(),
                AppResult.data(universityScreenState),
              ]));

      expect(
        viewModel.universities,
        emitsInOrder([
          const AppResult<UniversityScreenState>.loading(),
          AppResult<UniversityScreenState>.data(UniversityScreenState(
              universities: universityScreenState.universities))
        ]),
      );
    });

    test(
        'Test viewModel calls GetUniversitiesByCountryUseCase when stream universities is subscribed and gets loading and appError',
        () {
      when(useCase.invoke(null))
          .thenAnswer((realInvocation) => Stream.fromIterable([
                const AppResult.loading(),
                const AppResult.appError("Error"),
              ]));

      expect(
        viewModel.universities,
        emitsInOrder([
          const AppResult<UniversityScreenState>.loading(),
          const AppResult<UniversityScreenState>.appError("Error"),
        ]),
      );
    });

    test(
        'Test viewModel calls GetUniversitiesByCountryUseCase when stream universities is subscribed and gets loading and apiError',
        () {
      ApiError apiError = ApiError(statusCode: 500, message: "Server Error");
      when(useCase.invoke(null))
          .thenAnswer((realInvocation) => Stream.fromIterable([
                const AppResult.loading(),
                AppResult.apiError(apiError),
              ]));

      expect(
        viewModel.universities,
        emitsInOrder([
          const AppResult<UniversityScreenState>.loading(),
          AppResult<UniversityScreenState>.apiError(apiError),
        ]),
      );
    });

    test('Test viewModel search by country', () async {
      // We need to mock the call with null parameter because this is always
      // called by the universities stream when it gets a new subscriber
      when(useCase.invoke(null)).thenAnswer((_) => Stream.fromIterable([
            const AppResult.loading(),
            AppResult.data(UniversityScreenState(universities: [])),
          ]));
      when(useCase.invoke("test country")).thenAnswer(
          (_) => Stream.value(AppResult.data(universityScreenState)));
      expect(
        viewModel.universities,
        emitsInOrder([
          const AppResult<UniversityScreenState>.loading(),
          AppResult<UniversityScreenState>.data(
              UniversityScreenState(universities: [])),
          AppResult<UniversityScreenState>.data(UniversityScreenState(
              universities: universityScreenState.universities))
        ]),
      );
      // Since "expect" does async calls to verify our streams we need to wait
      // for some milliseconds before we trigger a search, otherwise the searchByCountry
      // method is called and an event will be sent to the universities stream
      // right after it was bind and then the order of the responses won't match anymore
      await Future.delayed(const Duration(milliseconds: 500));
      viewModel.searchByCountry("test country");
    });
  });
}
