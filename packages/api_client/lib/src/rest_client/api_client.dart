
import 'package:app_core/app_core.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';
@RestApi(baseUrl: 'https://dummyjson.com')
// ignore: one_member_abstracts
abstract class ApiClient {
  factory ApiClient (Dio dio)= _ApiClient;
  @POST('/auth/login')
  Future<UserModel> login( @Body() SignInForm form );

}
