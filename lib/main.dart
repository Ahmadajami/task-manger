import 'package:api_client/api_client.dart';

import 'package:task_manger_app/app/app_bootstrap.dart';

import 'package:task_manger_app/app/view/app.dart';
import 'package:user_repository/user_repository.dart';


Future<void> main() async {
  await bootstrap(
    builder: () async {
      final apiClient=ApiClient(buildDio());
      final userRepository=UserRepository(client: apiClient);
      return App(userRepository: userRepository,);
    },
  );
}