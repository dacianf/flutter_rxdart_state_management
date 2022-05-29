import 'package:flutter_test/flutter_test.dart';
import 'package:rxdart_state_management_article/network_config/api_error.dart';
import 'package:rxdart_state_management_article/network_config/app_result.dart';
import 'package:rxdart_state_management_article/utils/extensions/future_extensions.dart';

void main() {
  group("Test safeApi extension", () {
    test('Test Future emits data', () {
      expect(
        Future<String>.value("Test").safeApi(),
        emitsInOrder([
          const AppResult<String>.loading(),
          const AppResult<String>.data("Test"),
        ]),
      );
    });

    test('Test Future emits appError', () {
      expect(
        Future<String>.error(Exception("ERROR")).safeApi(),
        emitsInOrder([
          const AppResult<String>.loading(),
          AppResult<String>.appError(Exception("ERROR").toString()),
        ]),
      );
    });

    test('Test Future emits apiError from ApiError', () {
      ApiError apiError =
          ApiError(statusCode: 500, message: "Internal Server Error!");
      expect(
        Future<String>.error(apiError).safeApi(),
        emitsInOrder([
          const AppResult<String>.loading(),
          AppResult<String>.apiError(apiError),
        ]),
      );
    });
  });

  group("Test safeApiConvert extension", () {
    String converter(int value) {
      return value.toString();
    }

    test('Test Future emits data', () {
      expect(
        Future<int>.value(1).safeApiConvert(converter),
        emitsInOrder([
          const AppResult<String>.loading(),
          const AppResult<String>.data("1"),
        ]),
      );
    });

    test('Test Future emits appError', () {
      expect(
        Future<int>.error(Exception("ERROR")).safeApiConvert(converter),
        emitsInOrder([
          const AppResult<String>.loading(),
          AppResult<String>.appError(Exception("ERROR").toString()),
        ]),
      );
    });

    test('Test Future emits apiError from ApiError', () {
      ApiError apiError =
          ApiError(statusCode: 500, message: "Internal Server Error!");
      expect(
        Future<int>.error(apiError).safeApiConvert(converter),
        emitsInOrder([
          const AppResult<String>.loading(),
          AppResult<String>.apiError(apiError),
        ]),
      );
    });
  });
}
