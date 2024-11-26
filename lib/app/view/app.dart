import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manger_app/app/view/cubit/app_cubit.dart';
import 'package:task_manger_app/routing/routes.dart';
import 'package:todo_repository/todo_repository.dart';
import 'package:user_repository/user_repository.dart';

class App extends StatelessWidget {
  const App({
    required this.userRepository,
    required this.todoRepository,
    super.key,
  });

  final UserRepository userRepository;
  final TodoRepository todoRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>.value(value: userRepository, ),
        RepositoryProvider<TodoRepository>.value(value:todoRepository )
      ,],
      child: MultiBlocProvider(providers: [
        BlocProvider(
          create: (context) => AppCubit(userRepository: userRepository),
        ),
        BlocProvider(
          create: (context) => AppThemeCubit(),
        ),
      ], child: const AppView(),),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppCubit, AppState>(
      listenWhen: (previous, current) => previous!=current,
      listener: (context, state) {
        router.refresh();
      },
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        restorationScopeId: 'root',
        title: 'Maids cc Tasks',
        routerConfig: router,
        themeMode: context.watch<AppThemeCubit>().state,
        theme: lightTheme,
        darkTheme: darkTheme,
      ),
    );
  }
}
