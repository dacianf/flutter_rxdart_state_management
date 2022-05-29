import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rxdart_state_management_article/features/universities_feed/data/source/network/endpoint/university_endpoint.dart';
import 'package:rxdart_state_management_article/features/universities_feed/data/source/network/model/api_university_model.dart';

import '../../../../../network_config/mock_interceptor/dio_mock_responses_adapter.dart';

void main() {
  late Dio dioClient;
  late UniversityEndpoint endpoint;
  late String baseUrl;

  DioMockResponsesAdapter _createMockAdapterForSearchRequest(
      int responseCode, Object responseBody) {
    return DioMockResponsesAdapter(MockAdapterInterceptor(
      RequestType.GET,
      baseUrl,
      "/search",
      {"country": "us"},
      responseBody,
      responseCode,
    ));
  }

  List<Map<String, dynamic>> generateTwoValidUniversities() => [
        {
          "alpha_two_code": "US",
          "domains": ["marywood.edu"],
          "country": "United States",
          "state-province": null,
          "web_pages": ["http://www.marywood.edu"],
          "name": "Marywood University"
        },
        {
          "alpha_two_code": "US",
          "domains": ["lindenwood.edu"],
          "country": "United States",
          "state-province": null,
          "web_pages": ["http://www.lindenwood.edu/"],
          "name": "Lindenwood University"
        },
      ];

  List<ApiUniversityModel> expectedTwoValidUniversities() => [
        ApiUniversityModel(
          alphaCode: "US",
          country: "United States",
          state: null,
          name: "Marywood University",
          websites: ["http://www.marywood.edu"],
          domains: ["marywood.edu"],
        ),
        ApiUniversityModel(
          alphaCode: "US",
          country: "United States",
          state: null,
          name: "Lindenwood University",
          websites: ["http://www.lindenwood.edu/"],
          domains: ["lindenwood.edu"],
        ),
      ];

  group("Test University Endpoint API calls", () {
    setUp(() {
      baseUrl = "https://test.url";
      dioClient = Dio(BaseOptions());
      endpoint = UniversityEndpoint(dioClient, baseUrl: baseUrl);
    });

    test('Test endpoint calls dio', () async {
      dioClient.httpClientAdapter = _createMockAdapterForSearchRequest(
        200,
        [],
      );
      var result = await endpoint.getUniversitiesByCountry("us");
      expect(result, <ApiUniversityModel>[]);
    });

    test('Test endpoint returns error', () async {
      dioClient.httpClientAdapter = _createMockAdapterForSearchRequest(
        404,
        {"error": "Not found!"},
      );
      List<ApiUniversityModel>? response;
      DioError? error;
      try {
        response = await endpoint.getUniversitiesByCountry("us");
      } on DioError catch (dioError, _) {
        error = dioError;
      }
      expect(response, null);
      expect(error?.error, "Http status error [404]");
    });

    test('Test endpoint calls and returns 2 valid universities', () async {
      dioClient.httpClientAdapter = _createMockAdapterForSearchRequest(
        200,
        generateTwoValidUniversities(),
      );
      var result = await endpoint.getUniversitiesByCountry("us");
      expect(result, expectedTwoValidUniversities());
    });
  });
}
