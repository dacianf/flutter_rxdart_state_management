import 'package:rxdart/rxdart.dart';
import 'package:rxdart_state_management_article/features/universities_feed/domain/usecase/get_universities_by_country_use_case.dart';
import 'package:rxdart_state_management_article/features/universities_feed/presentation/models/university_screen_state.dart';
import 'package:rxdart_state_management_article/network_config/app_result.dart';

class UniversitiesViewModel {
  final GetUniversitiesByCountryUseCase _getUniversitiesByCountryUseCase;

  final Subject<String?> _searchByCountry = PublishSubject();

  late Stream<AppResult<UniversityScreenState>> universities;

  UniversitiesViewModel(
      {GetUniversitiesByCountryUseCase? getUniversitiesByCountryUseCase})
      : _getUniversitiesByCountryUseCase = getUniversitiesByCountryUseCase ??
            GetUniversitiesByCountryUseCase() {
    universities = _searchByCountry
        .startWith(null)
        .flatMap((value) => _getUniversitiesByCountryUseCase.invoke(value));
  }

  void searchByCountry(String country) {
    _searchByCountry.add(country);
  }
}
