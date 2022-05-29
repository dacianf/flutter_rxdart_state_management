import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rxdart_state_management_article/utils/extensions/map_extensions.dart';

class DioMockResponsesAdapter extends HttpClientAdapter {
  final MockAdapterInterceptor interceptor;

  DioMockResponsesAdapter(this.interceptor);

  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(RequestOptions options,
      Stream<Uint8List>? requestStream, Future? cancelFuture) {
    if (options.method == interceptor.type.name.toUpperCase() &&
        options.baseUrl == interceptor.uri &&
        options.queryParameters.hasSameElementsAs(interceptor.query) &&
        options.path == interceptor.path) {
      return Future.value(ResponseBody.fromString(
        jsonEncode(interceptor.serializableResponse),
        interceptor.responseCode,
        headers: {
          "content-type": ["application/json"]
        },
      ));
    }
    return Future.value(ResponseBody.fromString(
        jsonEncode(
            {"error": "Request doesn't match the mock interceptor details!"}),
        -1,
        statusMessage: "Request doesn't match the mock interceptor details!"));
  }
}

enum RequestType { GET, POST, PUT, PATCH, DELETE }

class MockAdapterInterceptor {
  final RequestType type;
  final String uri;
  final String path;
  final Map<String, dynamic> query;
  final Object serializableResponse;
  final int responseCode;

  MockAdapterInterceptor(this.type, this.uri, this.path, this.query,
      this.serializableResponse, this.responseCode);
}
