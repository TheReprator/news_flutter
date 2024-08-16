import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_flutter/di/di.dart';
import 'package:news_flutter/domain/modals/modal_news.dart';
import 'package:news_flutter/presentation/controller/news_bloc.dart';
import 'package:news_flutter/presentation/controller/news_bloc_event.dart';
import 'package:news_flutter/presentation/controller/news_bloc_state.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: ((context) =>
            getIt<NewsBloc>()..add(const NewsEvent.loading('Sports'))),
        child: BlocBuilder<NewsBloc, NewsState>(
            builder: (BuildContext _, NewsState state) {
          switch (state) {
            case NewsStateInit() || NewsStateLoading():
              return _widgetLoading;
            case NewsStateError(exception: final error):
              return _widgetError(error.toString());
            case NewsStateEmpty():
              return const Text('empty');
            case NewsStatePaginatedMore():
              return const Text('Load more');
            case NewsStatePaginatedError():
              return const Text('paginated error');
            case NewsStateContent(data: final data):
              return _widgetNewsList(data);
          }
        }));
  }

  Widget get _widgetLoading => const Center(
        child: CircularProgressIndicator(),
      );

  Widget _widgetError(String message) => Center(
        child: Text(message),
      );

  Widget _widgetNewsList(final List<ModalNews> data) =>
      ListView.builder(itemBuilder: (BuildContext context, int index) {
        return Text(data[index].description);
      });
}
