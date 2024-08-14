import 'package:built_value/standard_json_plugin.dart';
import 'package:chopper/chopper.dart';
import 'package:http/http.dart';
import 'package:news_flutter/di/impl/network/apikey_interceptor_request.dart';
import 'package:news_flutter/di/impl/network/built_value_converter.dart';
import 'package:news_flutter/di/impl/network/entity_error.dart';
import 'package:news_flutter/di/impl/network/serializers.dart';

class ChopperClientBuilder {
  static ChopperClient buildChopperClient(List<ChopperService> services,
          [BaseClient? httpClient]) =>
      ChopperClient(
          client: httpClient,
          baseUrl: Uri.parse('https://newsapi.org'),
          services: services,
          converter: converter(),
          interceptors: [ApikeyInterceptorRequest('sgysw')]);

  static BuiltValueConverter converter() {
    final jsonSerializers =
        (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();

    return BuiltValueConverter(jsonSerializers, errorType: EntityError);
  }
}
