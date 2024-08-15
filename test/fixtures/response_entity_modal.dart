import 'package:news_flutter/data/repository/remote/entity/entity_news.dart';
import 'package:news_flutter/di/impl/network/entity_error.dart';
import 'package:news_flutter/domain/modals/modal_news.dart';

const testResponseExceptionMessage = 'An error occurred';
const testResponseSourceId = '1';
const testResponseSourceName = 'google';
const testResponseNewsAuthor = 'vikram';
const testResponseNewsTitle = 'Software Developer';
const testResponseNewsDescription = 'Searching for job';
const testResponseNewsUrl = 'https://www.google.com';
const testResponseNewsUrlToImage = 'https://www.google.com';
const testResponseNewsPublishedAt = '23-August-2026';
const testResponseNewsContent = 'Actively searching for job';
const testResponseNewsCategory = 'sports';
const testResponseErrorMissingKey =
    'Your API key is missing. Append this to the URL with the apiKey param, or use the x-api-key HTTP header';

final testResponseNonNullableEntitySourceBuilder = EntitySourceBuilder()
  ..id = testResponseSourceId
  ..name = testResponseSourceName;

final testResponseNonNullableEntityNews = EntityNews((b) {
  b.source = testResponseNonNullableEntitySourceBuilder;
  b.author = testResponseNewsAuthor;
  b.title = testResponseNewsTitle;
  b.description = testResponseNewsDescription;
  b.url = testResponseNewsUrl;
  b.urlToImage = testResponseNewsUrlToImage;
  b.publishedAt = testResponseNewsPublishedAt;
  b.content = testResponseNewsContent;
});

final testResponseNullableEntitySourceBuilder = EntitySourceBuilder()
  ..id = testResponseSourceId
  ..name = testResponseSourceName;

final testResponseNullableEntityNews = EntityNews((b) {
  b.source = null;
  b.author = null;
  b.title = null;
  b.description = null;
  b.url = null;
  b.urlToImage = null;
  b.publishedAt = null;
  b.content = null;
});

const testResponseNonNullableModalSource =
    ModalSource(id: testResponseSourceId, name: testResponseSourceName);

const testResponseNonNullableModalNews = ModalNews(
    source: testResponseNonNullableModalSource,
    author: testResponseNewsAuthor,
    title: testResponseNewsTitle,
    description: testResponseNewsDescription,
    url: testResponseNewsUrl,
    urlToImage: testResponseNewsUrlToImage,
    publishedAt: testResponseNewsPublishedAt,
    content: testResponseNewsContent,
    category: testResponseNewsCategory);

final testResponseNonNullableEntityError = EntityError((b) {
  b.status = 'error';
  b.code = 'apiKeyMissing';
  b.message = testResponseErrorMissingKey;
});
