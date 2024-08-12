import 'dart:async';

import 'package:chopper/chopper.dart';

class ApikeyInterceptorRequest implements Interceptor {
  ApikeyInterceptorRequest(this.apiKey);

  final String apiKey;

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(
      Chain<BodyType> chain) async {
    final request = applyHeader(chain.request, 'apikey', apiKey);
    return chain.proceed(request);
  }
}
