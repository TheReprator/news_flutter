import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_flutter/domain/usecases/news_usecase.dart';
import 'package:news_flutter/presentation/controller/news_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_flutter/presentation/controller/news_bloc_event.dart';
import 'package:news_flutter/presentation/controller/news_bloc_state.dart';
import 'package:news_flutter/util/app_result_container.dart';

import '../../fixtures/response_entity_modal.dart';

class _MockNewsUseCase extends Mock implements NewsUseCase {}

void main() {
  late NewsBloc newsBloc;
  late _MockNewsUseCase newsUseCase;

  setUpAll(() {
    newsUseCase = _MockNewsUseCase();
    newsBloc = NewsBloc(newsUseCase);
  });

  test('should be equal to Initial State', () async {
    expect(newsBloc.state, equals(const NewsStateInit()));
  });

  blocTest<NewsBloc, NewsState>(
    'emits [Loading, NewsStateContent] when app is initialized',
    build: () {
      when(() => newsUseCase(testResponseNewsCategory, 1, 20)).thenAnswer(
          (_) async => const AppSuccess([testResponseNonNullableModalNews]));
      return newsBloc;
    },
    act: (bloc) => bloc.add(const NewsEventLoading(testResponseNewsCategory)),
    expect: () => [
      const NewsStateLoading(),
      const NewsStateContent(data: [testResponseNonNullableModalNews])
    ],
    verify: (_) {
      verify(() => newsUseCase(testResponseNewsCategory, 1, 20)).called(1);
    },
  );

  blocTest<NewsBloc, NewsState>(
    'emits [Loading, NewsStateEmpty] when app is initialized but data is empty',
    build: () {
      when(() => newsUseCase(testResponseNewsCategory, 1, 20))
          .thenAnswer((_) async => const AppSuccess([]));
      return newsBloc;
    },
    act: (bloc) => bloc.add(const NewsEventLoading(testResponseNewsCategory)),
    expect: () => [const NewsStateLoading(), const NewsStateEmpty()],
    verify: (_) {
      verify(() => newsUseCase(testResponseNewsCategory, 1, 20)).called(1);
    },
  );

  blocTest<NewsBloc, NewsState>(
    'emits [Loading, NewsStateError] when get news failed during app initialze',
    build: () {
      when(() => newsUseCase(testResponseNewsCategory, 1, 20)).thenAnswer(
          (_) async => const AppFailure(testResponseExceptionMessage));
      return newsBloc;
    },
    act: (bloc) => bloc.add(const NewsEventLoading(testResponseNewsCategory)),
    expect: () => [
      const NewsStateLoading(),
      const NewsStateError(testResponseExceptionMessage)
    ],
    verify: (_) {
      verify(() => newsUseCase(testResponseNewsCategory, 1, 20)).called(1);
    },
  );

  blocTest<NewsBloc, NewsState>(
    'emits [Loading, NewsStateContent] when get news successfully on retry',
    build: () {
      when(() => newsUseCase('', 1, 20)).thenAnswer(
          (_) async => const AppSuccess([testResponseNonNullableModalNews]));
      return newsBloc;
    },
    act: (bloc) => bloc.add(const NewsEventRetry()),
    expect: () => [
      const NewsStateLoading(),
      const NewsStateContent(data: [testResponseNonNullableModalNews])
    ],
    verify: (_) {
      verify(() => newsUseCase('', 1, 20)).called(1);
    },
  );

  blocTest<NewsBloc, NewsState>(
    'emits [NewsStatePaginatedMore, NewsStateContent] when user reaches end of page for load more',
    build: () {
      when(() => newsUseCase('', 1, 20)).thenAnswer(
          (_) async => const AppSuccess([testResponseNonNullableModalNews]));
      return newsBloc;
    },
    act: (bloc) => bloc.add(const NewsEventLoadMore()),
    expect: () => [
      const NewsStatePaginatedMore(),
      const NewsStateContent(data: [testResponseNonNullableModalNews])
    ],
    verify: (_) {
      verify(() => newsUseCase('', 1, 20)).called(1);
    },
  );
}
