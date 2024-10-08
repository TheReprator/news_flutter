import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:news_flutter/data/repository/remote/entity/entity_news.dart';
import 'package:news_flutter/di/impl/network/entity_error.dart';

part 'serializers.g.dart';

@SerializersFor([EntityNews, EntitySource, EntityError])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
