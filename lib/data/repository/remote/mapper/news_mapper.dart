import 'package:injectable/injectable.dart';
import 'package:news_flutter/data/repository/remote/entity/entity_news.dart';
import 'package:news_flutter/domain/modals/modal_news.dart';
import 'package:news_flutter/util/mapper.dart';

@named
@Injectable(as: Mapper)
class NewsMapper extends Mapper<EntityNews, String, ModalNews> {
  @override
  ModalNews mapTo(EntityNews from, String? supportingInput) {
    final source =
        ModalSource(id: from.source?.id ?? '0', name: from.source?.name ?? '');
    final news = ModalNews(
        source: source,
        author: from.author ?? '',
        title: from.title ?? '',
        description: from.description ?? '',
        url: from.url ?? '',
        urlToImage: from.urlToImage ?? '',
        publishedAt: from.publishedAt ?? '',
        content: from.content ?? '',
        category: supportingInput ?? '');
    return news;
  }
}
