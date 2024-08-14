import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:news_flutter/domain/modals/modal_news.dart';
import 'package:news_flutter/domain/usecases/new_usecase.dart';
import 'package:news_flutter/presentation/controller/news_bloc_event.dart';
import 'package:news_flutter/presentation/controller/news_bloc_state.dart';
import 'package:news_flutter/presentation/controller/news_holder.dart';
import 'package:news_flutter/util/app_result_container.dart';

@injectable
class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsUseCase _newsUseCase;

  NewsHolder _newsHolder =
      NewsHolder(newsList: [], newsCategory: "", pageFetched: 1);

  NewsBloc(this._newsUseCase) : super(const NewsState.init()) {
    on<NewsEventLoading>(_getNews);
    on<NewsEventLoadMore>(_getNewsLoadMore);
    on<NewsEventRetry>(_retry);
  }

  Future<void> _getNewsCommon(
    Emitter<NewsState> emit, {
    required Function() callBackInit,
    required Function(Exception e) callBackError,
    emptyResultCallBack,
  }) async {
    callBackInit();

    final AppResult<List<ModalNews>, Exception> resultContainer =
        await _newsUseCase(_newsHolder.newsCategory, _newsHolder.pageFetched);

    switch (resultContainer) {
      case AppSuccess(value: List<ModalNews> data):
        {
          if (data.isEmpty) {
            emptyResultCallBack();
          } else {
            _newsHolder = _newsHolder.copyWith(
                newsList: data, pageFetched: _newsHolder.pageFetched + 1);
            emit(NewsState.content(data: _newsHolder.newsList));
          }
        }
        break;
      case AppFailure(exception: Exception e):
        {
          callBackError(e);
        }
        break;
    }
  }

  void _getNews(NewsEventLoading event, Emitter<NewsState> emit) async {
    await _getNewsCommon(emit, callBackInit: () async {
      emit(const NewsStateLoading());
      _newsHolder.clearModalData(event.category);
      _newsHolder = _newsHolder.copyWith(newsCategory: event.category);
    }, callBackError: (Exception e) {
      emit(NewsState.error(e));
    }, emptyResultCallBack: () {
      emit(const NewsState.empty());
    });
  }

  void _getNewsLoadMore(
      NewsEventLoadMore event, Emitter<NewsState> emit) async {
    await _getNewsCommon(emit, callBackInit: () {
      emit(const NewsState.paginatedMore());
    }, callBackError: (Exception e) {
      emit(NewsState.paginatedError(e));
    }, emptyResultCallBack: () {});
  }

  void _retry(NewsEventRetry event, Emitter<NewsState> emit) async {
    await _getNewsCommon(emit, callBackInit: () {
      emit(const NewsState.paginatedMore());
    }, callBackError: (Exception e) {
      emit(NewsState.paginatedError(e));
    }, emptyResultCallBack: () {});
  }
}
