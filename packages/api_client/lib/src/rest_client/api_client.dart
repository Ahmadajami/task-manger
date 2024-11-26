import 'package:app_core/app_core.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:todo_repository/todo_repository.dart';
import 'package:user_repository/user_repository.dart';


part 'api_client.g.dart';

@RestApi(baseUrl: 'https://dummyjson.com')
// ignore: one_member_abstracts
abstract class ApiClient {
  factory ApiClient(Dio dio) = _ApiClient;
  /// UserRepo API
  @POST('/auth/login')
  Future<UserModel> login(@Body() SignInForm form);
  /// End   UserRepo API

  /// TodoRepo API
  @GET('/auth/todos/random')
  Future<TodoModel> getTodo();

  @GET('/auth/todos')
  Future<TodoListModel> getTodos(
    @Query('limit') int limit,
    @Query('skip') int skip,
  );

  @PATCH('/auth/todos/{id}')
  Future<TodoModel> updateTodo(
      @Path() String id,
      @Body() TodoModel todo,
      );

  @POST('/auth/todos/add')
  Future<TodoModel> createTodo(
      @Body() TodoModel todo,
      );
}
