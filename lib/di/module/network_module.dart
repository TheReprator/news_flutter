import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';
import 'package:news_flutter/di/impl/network/api_service.dart';
import 'package:news_flutter/di/impl/network/apikey_interceptor_request.dart';
import 'package:news_flutter/di/impl/network/built_value_converter.dart';
import 'package:news_flutter/di/impl/network/entity_error.dart';
import 'package:news_flutter/util/enviorment.dart' as app_enviorment;

@module
abstract class NetworkModule {
  @lazySingleton
  ApiService get apiService;

  @Named("baseUrl")
  String get baseUrl => app_enviorment.Environment.serverUrl;

  @Named("apiKey")
  String get apiKey => app_enviorment.Environment.apiKey;

  @lazySingleton
  ChopperClient chopperClient(@Named('baseUrl') String baseUrl,
          @Named('interceptorList') List<Interceptor> interceptorList) =>
      ChopperClient(
        baseUrl: Uri.parse(baseUrl),
        interceptors: interceptorList,
        converter: BuiltValueConverter(),
        errorConverter:
            BuiltValueConverter(errorType: EntityError().runtimeType),
      );

  @Named('interceptorList')
  List<Interceptor> clientInterceptor(@Named('apiKey') apiKey) => [
        CurlInterceptor(),
        HttpLoggingInterceptor(),
        ApikeyInterceptorRequest(apiKey)
      ];
}
