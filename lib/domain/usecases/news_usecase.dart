import 'package:injectable/injectable.dart';
import 'package:news_flutter/data/repository/news_datasource_repository_impl.dart';
import 'package:news_flutter/domain/modals/modal_news.dart';
import 'package:news_flutter/domain/repository/news_repository.dart';
import 'package:news_flutter/util/app_result_container.dart';

const _pageSize = 20;

@injectable
class NewsUseCase {
  NewsUseCase(@Named.from(NewsDatasourceRepositoryImpl) this._newsRepository);

  final NewsRepository _newsRepository;

  Future<AppResult<List<ModalNews>, Exception>> call(String sources, int page,
          [int pageSize = _pageSize]) =>
      _newsRepository.getNews(sources, page, pageSize);
}
