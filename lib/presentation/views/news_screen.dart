import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_flutter/di/di.dart';
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
              return _widgetError(error);
            case NewsStateEmpty():
              return const Text('empty');
            case NewsStatePaginatedMore():
              return const Text('Load more');
            case NewsStatePaginatedError():
              return Text('paginated error');
            case NewsStateContent(data: final data):
              return Text('Data length: ${data.length}');
          }
        }));
  }

  Widget get _widgetLoading => const Center(
        child: CircularProgressIndicator(),
      );

  Widget _widgetError(Exception e) => Center(
        child: Text("Something went wrong. ${e.toString()}"),
      );
}
