import 'package:freezed_annotation/freezed_annotation.dart';

// required: associates our `main.dart` with the code generated by Freezed
part 'modal_news.freezed.dart';

@freezed
class ModalSource with _$ModalSource {
  const factory ModalSource({
    required String id,
    required String name,
  }) = _ModalSource;
}

@freezed
class ModalNews with _$ModalNews {
  const factory ModalNews({
    required ModalSource source,
    required String author,
    required String title,
    required String description,
    required String url,
    required String urlToImage,
    required String publishedAt,
    required String content,
    required String category,
  }) = _ModalNews;
}
