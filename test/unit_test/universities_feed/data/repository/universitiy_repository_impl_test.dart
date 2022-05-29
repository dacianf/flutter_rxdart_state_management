import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart_state_management_article/features/universities_feed/data/repository/university_repository_impl.dart';
import 'package:rxdart_state_management_article/features/universities_feed/data/source/university_remote_data_source.dart';
import 'package:rxdart_state_management_article/features/universities_feed/domain/entity/university.dart';
import 'package:rxdart_state_management_article/features/universities_feed/domain/repository/untiversities_repository.dart';
import 'package:rxdart_state_management_article/network_config/app_result.dart';

import 'universitiy_repository_impl_test.mocks.dart';

@GenerateMocks([UniversityRemoteDataSource])
void main() {
  late UniversityRemoteDataSource dataSource;
  late UniversitiesRepository repo;

  group("Test function calls", () {
    setUp(() {
      dataSource = MockUniversityRemoteDataSource();
      repo = UniversityRepositoryImpl(universityRemoteDataSource: dataSource);
    });

    test('Test repo calls getUniversitiesByCountry from data source', () {
      when(dataSource.getUniversitiesByCountry(null)).thenAnswer(
          (realInvocation) => Stream.value(const AppResult.data([])));

      repo.getUniversities(null);
      verify(dataSource.getUniversitiesByCountry(null));
    });

    test(
        'Test repo calls getUniversitiesByCountry from data source and gets error',
        () {
      when(dataSource.getUniversitiesByCountry(null)).thenAnswer(
          (realInvocation) => Stream.value(const AppResult.appError("ERROR")));

      expect(
        repo.getUniversities(null),
        emits(const AppResult<List<University>>.appError("ERROR")),
      );
    });

    test(
        'Test repo calls getUniversitiesByCountry from data source and gets data',
        () {
      University university = University(
          alphaCode: "alphaCode",
          country: "country",
          state: "state",
          name: "name",
          websites: ["websites"],
          domains: ["domains"]);

      when(dataSource.getUniversitiesByCountry(null)).thenAnswer(
          (realInvocation) => Stream.value(AppResult.data([university])));

      expect(
        repo.getUniversities(null),
        emits(AppResult.data([university.copyWith()])),
      );
    });
  });
}
