import 'package:chopper/chopper.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_flutter/data/datasource/news_datasource.dart';
import 'package:news_flutter/data/repository/remote/mapper/news_mapper.dart';
import 'package:news_flutter/data/repository/remote/news_datasource_remoteimpl.dart';
import 'package:news_flutter/di/impl/network/api_service.dart';
import 'package:news_flutter/domain/modals/modal_news.dart';
import 'package:news_flutter/util/app_result_container.dart';
import 'package:news_flutter/util/logger.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';
import '../../../../fixtures/response_entity_modal.dart';

class _MockApiService extends Mock implements ApiService {}

void main() {
  late final _MockApiService apiService;
  late final NewsDataSource newsDataSource;

  setUpAll(() {
    apiService = _MockApiService();
    newsDataSource =
        NewsDatasourceRemoteImpl(LoggerLogging(), apiService, NewsMapper());
  });

  test('successfully get news by category', () async {
    when(() => apiService.getHeadLines(testResponseNewsCategory, 1, 20))
        .thenAnswer((_) async {
      return [testResponseNonNullableEntityNews];
    });

    final appContainerResult =
        await newsDataSource.getNews(testResponseNewsCategory, 1, 20);
    expect(appContainerResult, isA<AppSuccess>());

    final newsList = (appContainerResult as AppSuccess<List<ModalNews>>).data;
    expect(newsList.length, 1);
    expect(newsList.first.author, testResponseNewsAuthor);
  });

  group('Api fetch error', () {
    test('general error', () async {
      when(() => apiService.getHeadLines(testResponseNewsCategory, 1, 20))
          .thenThrow(Exception('error type'));

      final appContainerResult =
          await newsDataSource.getNews(testResponseNewsCategory, 1, 20);

      // Assert
      expect(appContainerResult, isA<AppFailure<List<ModalNews>>>());
    });

    test('chopper error', () async {
      final response = Response(
          http.Response(testResponseNewsCategory, 401), 401,
          error: testResponseNonNullableEntityError);

      when(() => apiService.getHeadLines(testResponseNewsCategory, 1, 20))
          .thenThrow(ChopperHttpException(response));

      final appContainerResult =
          await newsDataSource.getNews(testResponseNewsCategory, 1, 20);

      expect(appContainerResult, isA<AppFailure<List<ModalNews>>>());

      final failResult = appContainerResult as AppFailure;
      expect(failResult.message, testResponseErrorMissingKey);
    });
  });
}
