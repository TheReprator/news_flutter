import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:news_flutter/data/repository/remote/entity/entity_news.dart';

part 'serializers.g.dart';

@SerializersFor([EntityNews, EntitySource])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
