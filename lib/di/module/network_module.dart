import 'package:built_value/standard_json_plugin.dart';
import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';
import 'package:news_flutter/di/impl/network/api_service.dart';
import 'package:news_flutter/di/impl/network/apikey_interceptor_request.dart';
import 'package:news_flutter/di/impl/network/built_value_converter.dart';
import 'package:news_flutter/di/impl/network/entity_error.dart';
import 'package:news_flutter/di/impl/network/serializers.dart';
import 'package:news_flutter/util/enviorment.dart' as app_enviorment;

const _namedApiKey = 'apiKey';
const _namedApiUrl = 'apiUrl';
const _namedInterceptorList = 'interceptorList';
const _namedSerializer = 'serializer';

@module
abstract class NetworkModule {
  @lazySingleton
  ApiService get apiService;

  @Named(_namedApiUrl)
  String get baseUrl => app_enviorment.Environment.serverUrl;

  @Named(_namedApiKey)
  String get apiKey => app_enviorment.Environment.apiKey;

  @lazySingleton
  ChopperClient chopperClient(
          @Named(_namedApiUrl) String baseUrl,
          @Named(_namedSerializer) BuiltValueConverter converter,
          @Named(_namedInterceptorList) List<Interceptor> interceptorList) =>
      ChopperClient(
          baseUrl: Uri.parse(baseUrl),
          interceptors: interceptorList,
          errorConverter: converter,
          converter: converter);

  @Named(_namedInterceptorList)
  List<Interceptor> clientInterceptor(@Named(_namedApiKey) String apiKey) => [
        CurlInterceptor(),
        HttpLoggingInterceptor(),
        ApikeyInterceptorRequest(apiKey)
      ];

  @Named(_namedSerializer)
  BuiltValueConverter converter() {
    final jsonSerializers =
        (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();

    return BuiltValueConverter(jsonSerializers, errorType: EntityError);
  }
}
