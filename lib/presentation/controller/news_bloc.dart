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

  void _getNewsCommon(
    Emitter<NewsState> emit, {
    required Function() callBackInit,
    required Function(Exception e) errorResultCallBack,
    emptyResultCallBack,
  }) async {
    callBackInit();
    final newsContainer =
        await _newsUseCase(_newsHolder.newsCategory, _newsHolder.pageFetched);

    switch (newsContainer) {
      case AppSuccess(value: List<ModalNews> data):
        {
          if (data.isEmpty) {
            emptyResultCallBack();
          } else {
            _newsHolder = _newsHolder.copyWith(
                newsList: data, pageFetched: _newsHolder.pageFetched + 1);
            emit(NewsState.content(data: data));
          }
        }
        break;
      case AppFailure(exception: Exception e):
        {
          errorResultCallBack(e);
        }
        break;
    }
  }

  void _getNews(NewsEventLoading event, Emitter<NewsState> emit) async {
    _getNewsCommon(emit, callBackInit: () {
      emit(const NewsStateLoading());
      _newsHolder.clearModalData(event.category);
      _newsHolder = _newsHolder.copyWith(newsCategory: event.category);
    }, errorResultCallBack: (Exception e) {
      emit(NewsState.error(e));
    }, emptyResultCallBack: () {
      emit(const NewsState.empty());
    });
  }

  void _getNewsLoadMore(
      NewsEventLoadMore event, Emitter<NewsState> emit) async {
    _getNewsCommon(emit, callBackInit: () {
      emit(const NewsState.paginatedMore());
    }, errorResultCallBack: (Exception e) {
      emit(NewsState.paginatedError(e));
    }, emptyResultCallBack: () {});
  }

  void _retry(NewsEventRetry event, Emitter<NewsState> emit) {
    _getNewsCommon(emit, callBackInit: () {
      emit(const NewsState.paginatedMore());
    }, errorResultCallBack: (Exception e) {
      emit(NewsState.paginatedError(e));
    }, emptyResultCallBack: () {});
  }
}
