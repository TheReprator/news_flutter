import 'package:news_flutter/domain/modals/modal_news.dart';

class NewsHolder {
  final List<ModalNews> newsList;
  final String newsCategory;
  final int pageFetched;

  NewsHolder(
      {required this.newsList,
      required this.newsCategory,
      required this.pageFetched});

  NewsHolder clearModalData(String newsCategory) {
    return NewsHolder(
      newsList: List.empty(),
      newsCategory: newsCategory,
      pageFetched: 0,
    );
  }

  NewsHolder copyWith(
      {List<ModalNews>? newsList, String? newsCategory, int? pageFetched}) {
    if (null == newsList)
      this.newsList;
    else
      this.newsList.addAll(newsList);

    return NewsHolder(
      newsList: this.newsList,
      newsCategory: newsCategory ?? this.newsCategory,
      pageFetched: pageFetched ?? this.pageFetched,
    );
  }
}
