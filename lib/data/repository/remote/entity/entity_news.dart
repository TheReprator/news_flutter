import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'entity_news.g.dart';

abstract class EntityNews implements Built<EntityNews, EntityNewsBuilder> {
  EntityNews._();

  EntitySource? get source;
  String? get author;
  String? get title;
  String? get description;
  String? get url;
  String? get urlToImage;
  String? get publishedAt;
  String? get content;

  factory EntityNews([void Function(EntityNewsBuilder) updates]) = _$EntityNews;

  static Serializer<EntityNews> get serializer => _$entityNewsSerializer;
}

abstract class EntitySource
    implements Built<EntitySource, EntitySourceBuilder> {
  String? get name;
  String? get id;

  EntitySource._();

  factory EntitySource([void Function(EntitySourceBuilder) updates]) =
      _$EntitySource;

  static Serializer<EntitySource> get serializer => _$entitySourceSerializer;
}
