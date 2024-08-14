import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';
import 'package:news_flutter/data/datasource/news_datasource.dart';
import 'package:news_flutter/data/repository/remote/entity/entity_news.dart';
import 'package:news_flutter/data/repository/remote/mapper/news_mapper.dart';
import 'package:news_flutter/di/impl/network/api_service.dart';
import 'package:news_flutter/di/impl/network/entity_error.dart';
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
    } on ChopperHttpException catch (error, stacktrace) {
      _logger.debug(stacktrace);
      _logger.debug(error);

      String errorMessage;
      final errorObject = error.response.error;
      switch (errorObject) {
        case EntityError():
          errorMessage = errorObject.message ?? '';
          break;
        default:
          errorMessage = 'An error occurred';
      }
      return AppFailure(Exception(errorMessage));
    } on Exception catch (error, stacktrace) {
      _logger.debug(stacktrace);
      _logger.debug(error);

      return AppFailure(Exception('An error occurred'));
    }
  }
}
