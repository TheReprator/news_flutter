import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:chopper/chopper.dart';

class BuiltValueConverter implements Converter, ErrorConverter {
  final Serializers serializers;
  static const JsonConverter jsonConverter = JsonConverter();
  final Type? errorType;

  const BuiltValueConverter(this.serializers, {this.errorType});

  T? _deserialize<T>(dynamic value) {
    dynamic serializer;
    if (value is Map && value.containsKey('\$')) {
      serializer = serializers.serializerForWireName(value['\$']);
    }
    serializer ??= serializers.serializerForType(T);

    if (serializer == null) {
      throw 'Serializer not found for $T';
    }

    return serializers.deserializeWith<T>(serializer, value);
  }

  List<InnerType> _deserializeListOf<InnerType>(Iterable value) {
    final Iterable<InnerType?> deserialized =
        value.map((value) => _deserialize<InnerType>(value));

    final builtList =
        BuiltList<InnerType>(deserialized.toList(growable: false));
    return builtList.toList();
  }

  BodyType? deserialize<BodyType, InnerType>(entity) {
    if (entity is BodyType) return entity;
    if (entity is Iterable) {
      return _deserializeListOf<InnerType>(entity) as BodyType;
    }

    return _deserialize<BodyType>(entity);
  }

  @override
  Request convertRequest(Request request) => jsonConverter.convertRequest(
        request.copyWith(body: serializers.serialize(request.body)),
      );

  @override
  FutureOr<Response<BodyType>> convertResponse<BodyType, InnerType>(
    Response response,
  ) async {
    final Response jsonResponse = await jsonConverter.convertResponse(response);
    var rawBody = jsonResponse.body;

    if ((rawBody is Map<String, dynamic>) &&
        (rawBody.containsKey('articles'))) {
      rawBody = rawBody['articles'];
    }

    final res = jsonResponse.copyWith(
      body: deserialize<BodyType, InnerType>(rawBody),
    );
    return res;
  }

  @override
  FutureOr<Response> convertError<BodyType, InnerType>(
    Response response,
  ) async {
    final Response jsonResponse = await jsonConverter.convertResponse(response);

    dynamic body;

    try {
      // try to deserialize using wireName
      body ??= _deserialize(jsonResponse.body);
    } catch (_) {
      final type = errorType;
      // or check provided error type
      if (type != null) {
        final serializer = serializers.serializerForType(type);
        if (serializer != null) {
          body = serializers.deserializeWith(serializer, jsonResponse.body);
        }
      }
      body ??= jsonResponse.body;
    }

    return jsonResponse.copyWith(body: body);
  }
}
