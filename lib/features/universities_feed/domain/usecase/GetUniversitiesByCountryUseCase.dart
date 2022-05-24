import 'package:rxdart_state_management_article/features/universities_feed/data/repository/university_repository_impl.dart';
import 'package:rxdart_state_management_article/features/universities_feed/domain/repository/untiversities_repository.dart';
import 'package:rxdart_state_management_article/features/universities_feed/presentation/models/university_screen_model.dart';
import 'package:rxdart_state_management_article/features/universities_feed/presentation/models/university_screen_state.dart';
import 'package:rxdart_state_management_article/network_config/app_result.dart';

class GetUniversitiesByCountryUseCase {
  final UniversitiesRepository _universitiesRepository;

  GetUniversitiesByCountryUseCase(
      {UniversitiesRepository? universitiesRepository})
      : _universitiesRepository =
            universitiesRepository ?? UniversityRepositoryImpl();

  Stream<AppResult<UniversityScreenState>> invoke(String? country) {
    return _universitiesRepository.getUniversities(country).map((event) {
      return event.safeMap((p0) => UniversityScreenState(
            universities:
                p0.map((e) => UniversityScreenModel.fromDomain(e)).toList(),
          ));
    });
  }
}
