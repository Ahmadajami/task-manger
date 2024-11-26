import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final dio=Dio();

Dio buildDio(){
  dio.options.headers['Content-Type'] = 'application/json';


  dio.interceptors.addAll([
    PrettyDioLogger(

      maxWidth: 100,
      requestBody: true,
      requestHeader: true,
    ),
  ]);
  return dio;
}
