import 'package:mocktail/mocktail.dart';
import 'package:news_flutter/domain/modals/modal_news.dart';
import 'package:news_flutter/domain/repository/news_repository.dart';
import 'package:news_flutter/domain/usecases/news_usecase.dart';
import 'package:news_flutter/util/app_result_container.dart';
import 'package:test/test.dart';

import '../../../fixtures/response_entity_modal.dart';

class _MockNewsRepository extends Mock implements NewsRepository {}

void main() {
  late final NewsRepository newsRepository;
  late final NewsUseCase newsUseCase;

  setUpAll(() {
    newsRepository = _MockNewsRepository();
    newsUseCase = NewsUseCase(newsRepository);
  });

  test('successfully get news by category', () async {
    when(() => newsRepository.getNews(testResponseNewsCategory, 1, 20))
        .thenAnswer((_) async {
      return const AppSuccess([testResponseNonNullableModalNews]);
    });

    final appContainerResult =
        await newsUseCase(testResponseNewsCategory, 1, 20);
    expect(appContainerResult, isA<AppSuccess>());

    final newsList =
        (appContainerResult as AppSuccess<List<ModalNews>, Exception>).value;
    expect(newsList.length, 1);
    expect(newsList.first.author, testResponseNewsAuthor);
  });
}
