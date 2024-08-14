import 'package:mocktail/mocktail.dart';
import 'package:news_flutter/data/datasource/news_datasource.dart';
import 'package:news_flutter/data/repository/news_datasource_repository_impl.dart';
import 'package:news_flutter/domain/modals/modal_news.dart';
import 'package:news_flutter/domain/repository/news_repository.dart';
import 'package:news_flutter/util/app_result_container.dart';
import 'package:test/test.dart';

import '../../../fixtures/response_entity_modal.dart';

class _MockNewsDataSource extends Mock implements NewsDataSource {}

void main() {
  late final NewsDataSource newsDataSource;
  late final NewsRepository newsRepository;

  setUpAll(() {
    newsDataSource = _MockNewsDataSource();
    newsRepository = NewsDatasourceRepositoryImpl(newsDataSource);
  });

  test('successfully get news by category', () async {
    when(() => newsDataSource.getNews(testResponseNewsCategory, 1, 20))
        .thenAnswer((_) async {
      return const AppSuccess([testResponseNonNullableModalNews]);
    });

    final appContainerResult =
        await newsRepository.getNews(testResponseNewsCategory, 1, 20);

    expect(appContainerResult, isA<AppSuccess>());

    final newsList =
        (appContainerResult as AppSuccess<List<ModalNews>, Exception>).value;
    expect(newsList.length, 1);
    expect(newsList.first.author, testResponseNewsAuthor);
  });
}
