

import 'package:dio/dio.dart';

class TokenInterceptor extends Interceptor {

  TokenInterceptor({required String token}):_token=token;
  final String _token;



  @override
  Future<void> onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,) async {


    options.headers['Authorization'] = 'Bearer $_token';


    // Continue with the request
    return handler.next(options);
  }

}
