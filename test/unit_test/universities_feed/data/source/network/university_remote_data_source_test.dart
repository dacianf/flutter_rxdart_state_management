import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart_state_management_article/features/universities_feed/data/source/network/endpoint/university_endpoint.dart';
import 'package:rxdart_state_management_article/features/universities_feed/data/source/network/model/api_university_model.dart';
import 'package:rxdart_state_management_article/features/universities_feed/data/source/university_remote_data_source.dart';
import 'package:rxdart_state_management_article/features/universities_feed/domain/entity/university.dart';
import 'package:rxdart_state_management_article/network_config/api_error.dart';
import 'package:rxdart_state_management_article/network_config/app_result.dart';

import 'university_remote_data_source_test.mocks.dart';

@GenerateMocks([UniversityEndpoint])
void main() {
  late UniversityEndpoint endpoint;
  late UniversityRemoteDataSource dataSource;

  group("Test function calls", () {
    setUp(() {
      endpoint = MockUniversityEndpoint();
      dataSource = UniversityRemoteDataSource(universityEndpoint: endpoint);
    });

    test('Test dataSource calls getUniversitiesByCountry from endpoint', () {
      when(endpoint.getUniversitiesByCountry("test"))
          .thenAnswer((realInvocation) => Future.value(<ApiUniversityModel>[]));

      dataSource.getUniversitiesByCountry("test");
      verify(endpoint.getUniversitiesByCountry("test"));
    });

    test('Test dataSource maps getUniversitiesByCountry response to Stream',
        () {
      when(endpoint.getUniversitiesByCountry("test"))
          .thenAnswer((realInvocation) => Future.value(<ApiUniversityModel>[]));

      expect(
        dataSource.getUniversitiesByCountry("test"),
        emitsInOrder([
          const AppResult<List<University>>.loading(),
          const AppResult<List<University>>.data([])
        ]),
      );
    });

    test(
        'Test dataSource maps getUniversitiesByCountry response to Stream with error',
        () {
      ApiError mockApiError = ApiError(
        statusCode: 400,
        message: "error",
        errors: null,
      );
      when(endpoint.getUniversitiesByCountry("test"))
          .thenAnswer((realInvocation) => Future.error(mockApiError));

      expect(
        dataSource.getUniversitiesByCountry("test"),
        emitsInOrder([
          const AppResult<List<University>>.loading(),
          AppResult<List<University>>.apiError(mockApiError)
        ]),
      );
    });
  });
}
