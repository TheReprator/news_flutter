import 'package:injectable/injectable.dart';
import 'package:news_flutter/data/datasource/news_datasource.dart';
import 'package:news_flutter/data/repository/remote/entity/entity_news.dart';
import 'package:news_flutter/data/repository/remote/mapper/news_mapper.dart';
import 'package:news_flutter/di/impl/network/api_service.dart';
import 'package:news_flutter/domain/modals/modal_news.dart';
import 'package:news_flutter/util/app_result_container.dart';
import 'package:news_flutter/util/logger.dart';
import 'package:news_flutter/util/mapper.dart';

@named
@Injectable(as: NewsDataSource)
class NewsDatasourceRemoteImpl implements NewsDataSource {
  NewsDatasourceRemoteImpl(
      this._logger, this._apiService, @Named.from(NewsMapper) this._mapper);

  final Logger _logger;
  final ApiService _apiService;
  final Mapper<EntityNews, String, ModalNews> _mapper;

  @override
  Future<AppResult<List<ModalNews>, Exception>> getNews(
      String sources, int page, int pageSize) async {
    try {
      final List<EntityNews> itemList =
          await _apiService.getHeadLines(sources, page, pageSize);
      return AppSuccess(_mapper.mapToList(itemList, sources));
    } on Exception catch (error, stacktrace) {
      _logger.debug(stacktrace);
      return Future.delayed(Duration(seconds: 10), () async {
        // do something here
        return AppFailure(error);
        // do stuff
      });
    }
  }
}
