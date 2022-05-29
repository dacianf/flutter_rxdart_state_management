import 'package:rxdart_state_management_article/features/universities_feed/data/source/university_remote_data_source.dart';
import 'package:rxdart_state_management_article/features/universities_feed/domain/entity/university.dart';
import 'package:rxdart_state_management_article/features/universities_feed/domain/repository/untiversities_repository.dart';
import 'package:rxdart_state_management_article/network_config/app_result.dart';

class UniversityRepositoryImpl extends UniversitiesRepository {
  final UniversityRemoteDataSource _universityRemoteDataSource;

  UniversityRepositoryImpl(
      {UniversityRemoteDataSource? universityRemoteDataSource})
      : _universityRemoteDataSource =
            universityRemoteDataSource ?? UniversityRemoteDataSource();

  @override
  Stream<AppResult<List<University>>> getUniversities(String? country) {
    return _universityRemoteDataSource.getUniversitiesByCountry(country);
  }
}
