import 'package:news_flutter/domain/modals/modal_news.dart';
import 'package:news_flutter/util/app_result_container.dart';

abstract interface class NewsDataSource {
  Future<AppResult<List<ModalNews>, Exception>> getNews(
      String sources, int page, int pageSize);
}
