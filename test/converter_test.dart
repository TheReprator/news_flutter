import 'package:flutter/material.dart';
import 'package:news_flutter/di/impl/network/api_service.dart';
import 'package:test/test.dart';

import 'chopper_client.dart';
import 'mock_http_client.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final mockHttpClient = MockHttpClientBuilder().generateClient();

  final chopperClient = ChopperClientBuilder.buildChopperClient(
    [
      // ApiService.createa(),
    ],
    mockHttpClient,
  );

  group('BuiltValueConverter', () {
    test('convert response List', () async {
      final service = ApiService.create(chopperClient);

      final list1 = await service.getHeadLines('sdfs', 1, 20);
      final list = list1.toList();
      expect(list.length, equals(2));
      expect(list.first.author, equals('Alex Cranz'));
    });
  });
}
