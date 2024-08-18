import 'dart:async';
import 'dart:io';

import 'package:chopper/chopper.dart';

class ApikeyInterceptorRequest implements Interceptor {
  ApikeyInterceptorRequest(this.apiKey);

  final String apiKey;

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(
      Chain<BodyType> chain) async {
    final headers = {
      'Authorization': apiKey,
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
    };
    final request = applyHeaders(chain.request, headers);
    return chain.proceed(request);
  }
}
