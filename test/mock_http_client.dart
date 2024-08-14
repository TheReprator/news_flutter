import "dart:async";
import 'dart:io';
import 'package:http/http.dart';
import 'package:http/testing.dart';

class MockHttpClientBuilder {
  MockClient generateClient() {
    return MockClient(
      (request) async {
        try {
          final response = await _getResponseByPath(request.url.path);
          return Response(response, 200, headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          });
        } on PathNotFoundException catch (e) {
          return Response(e.message, 404);
        } catch (e) {
          return Response('Server Error', 500);
        }
      },
    );
  }

  Future<String> _getResponseByPath(String path) async {
    switch (path) {
      case '/v2/top-headlines':
        return await _readResponseFromAsset(
            '/Users/deepsandhya/Desktop/code/myProject/News/news_flutter/test/responseJson/response.json');
      default:
        throw PathNotFoundException(path, const OSError('Path error'));
    }
  }

  Future<String> _readResponseFromAsset(String filePath) async =>
      await File(filePath).readAsString();
}
