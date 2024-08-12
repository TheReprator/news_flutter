import 'package:built_value/serializer.dart';
import 'package:chopper/chopper.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:news_flutter/di/impl/network/serializers.dart';
import 'package:built_collection/built_collection.dart';
import 'dart:async';

class BuiltValueConverter extends JsonConverter
    implements Converter, ErrorConverter {
  final Type? errorType;

  BuiltValueConverter({this.errorType});

  final jsonSerializers =
      (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();

  T? _deserialize<T>(dynamic value) {
    final serializer = jsonSerializers.serializerForType(T) as Serializer<T>?;
    if (serializer == null) {
      throw Exception('No serializer for type $T');
    }

    return jsonSerializers.deserializeWith<T>(serializer, value);
  }

  BuiltList<T> _deserializeListOf<T>(Iterable value) => BuiltList(
        value.map((value) => _deserialize<T>(value)).toList(growable: false),
      );

  dynamic _decode<T>(dynamic entity) {
    /// handle case when we want to access to Map<String, dynamic> directly
    /// getResource or getMapResource
    /// Avoid dynamic or unconverted value, this could lead to several issues
    if (entity is T) return entity;

    try {
      return entity is List
          ? _deserializeListOf<T>(entity)
          : _deserialize<T>(entity);
    } catch (e) {
      return null;
    }
  }

  @override
  Request convertRequest(Request request) => super.convertRequest(
        request.copyWith(
          body: serializers.serialize(request.body),
        ),
      );

  @override
  FutureOr<Response<ResultType>> convertResponse<ResultType, Item>(
    Response response,
  ) async {
    // use [JsonConverter] to decode json
    final Response jsonRes = await super.convertResponse(response);
    final body = _decode<Item>(jsonRes.body);

    return jsonRes.copyWith<ResultType>(body: body);
  }

  @override
  FutureOr<Response> convertError<BodyType, InnerType>(
      Response response) async {
    final jsonResponse = await super.convertResponse(response);

    var body;

    try {
      body ??= _deserialize(jsonResponse.body);
    } catch (_) {
      if (null != errorType) {
        final serializer = jsonSerializers.serializerForType(errorType!);
        if (null != serializer) {
          body = jsonSerializers.deserializeWith(serializer, jsonResponse.body);
        }
      }
      body ??= jsonResponse.body;
    }

    return jsonResponse.copyWith(body: body);
  }
}
