import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:news_flutter/domain/modals/modal_news.dart';

part 'news_bloc_state.freezed.dart';

@freezed
sealed class NewsState with _$NewsState {
  const NewsState._();

  const factory NewsState.init() = NewsStateInit;

  const factory NewsState.loading() = NewsStateLoading;
  const factory NewsState.error(Exception exception) = NewsStateError;
  const factory NewsState.empty() = NewsStateEmpty;
  const factory NewsState.paginatedMore() = NewsStatePaginatedMore;
  const factory NewsState.paginatedError(Exception e) = NewsStatePaginatedError;

  const factory NewsState.content({required List<ModalNews> data}) =
      NewsStateContent;
}
