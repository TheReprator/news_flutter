import 'package:injectable/injectable.dart';
import 'package:news_flutter/data/datasource/news_datasource.dart';
import 'package:news_flutter/data/repository/remote/news_datasource_remoteimpl.dart';
import 'package:news_flutter/domain/modals/modal_news.dart';
import 'package:news_flutter/domain/repository/news_repository.dart';
import 'package:news_flutter/util/app_result_container.dart';

@named
@Injectable(as: NewsRepository)
class NewsDatasourceRepositoryImpl implements NewsRepository {
  NewsDatasourceRepositoryImpl(
      @Named.from(NewsDatasourceRemoteImpl) this._newsDataSourceRemote);

  final NewsDataSource _newsDataSourceRemote;

  @override
  Future<AppResult<List<ModalNews>, Exception>> getNews(
          String sources, int page, int pageSize) =>
      _newsDataSourceRemote.getNews(sources, page, pageSize);
}
