import 'package:news_flutter/data/repository/remote/entity/entity_news.dart';
import 'package:news_flutter/data/repository/remote/mapper/news_mapper.dart';
import 'package:news_flutter/domain/modals/modal_news.dart';
import 'package:news_flutter/util/mapper.dart';
import 'package:test/test.dart';

import '../../../../../fixtures/response_entity_modal.dart';

void main() {
  group('mapper non nullable conversion', () {
    test('entity news to modal news', () {
      final Mapper<EntityNews, String, ModalNews> mapper = NewsMapper();
      final modalOutput = mapper.mapTo(
          testResponseNonNullableEntityNews, testResponseNewsCategory);
      expect(modalOutput.author, testResponseNewsAuthor);
    });

    test('entity news list to modal news list', () {
      final Mapper<EntityNews, String, ModalNews> mapper = NewsMapper();
      final modalOutputList = mapper.mapToList(
          [testResponseNonNullableEntityNews], testResponseNewsCategory);

      expect(modalOutputList.length, 1);
      expect(modalOutputList.first.author, testResponseNewsAuthor);
    });
  });
}
