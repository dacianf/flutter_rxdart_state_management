import 'package:rxdart_state_management_article/features/universities_feed/domain/entity/university.dart';
import 'package:rxdart_state_management_article/network_config/app_result.dart';

abstract class UniversitiesRepository {
  Stream<AppResult<List<University>>> getUniversities(String? country);
}
