import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_bloc_event.freezed.dart';

@freezed
sealed class NewsEvent with _$NewsEvent {
  const NewsEvent._();

  const factory NewsEvent.loading(String category) = NewsEventLoading;
  const factory NewsEvent.loadMore() = NewsEventLoadMore;
  const factory NewsEvent.retry() = NewsEventRetry;
}
