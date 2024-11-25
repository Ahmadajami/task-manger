// ignore_for_file: no_leading_underscores_for_local_identifiers
// ignore_for_file: omit_local_variable_types
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manger_app/app/view/cubit/app_cubit.dart';
import 'package:task_manger_app/home/home.dart';
import 'package:task_manger_app/login/login_screen.dart';
import 'package:task_manger_app/routing/wrapper.dart';
import 'package:task_manger_app/setting/setting.dart';
import 'package:task_manger_app/setting/view/theme/theme_screen.dart';
import 'package:task_manger_app/task/task.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _sectionANavigatorKey =
GlobalKey<NavigatorState>();


  final GoRouter  router = GoRouter(
    restorationScopeId: 'routes',
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/auth',
   redirect: (context, state)  {

      final isAuth=context.read<AppCubit>().state.status.isAuthenticated;
      final isLoginPage=state.fullPath == '/auth';
      if(isLoginPage)
      {
        log(isAuth.toString());
        return isAuth ? '/': null;
      }
      return isAuth ? null : '/auth';
    },
    routes: [
      GoRoute(
        path: '/auth',
        builder: (context, state) => const LoginPage(),),
      StatefulShellRoute.indexedStack(
        restorationScopeId: 'routes_shell',
        builder: (BuildContext context, GoRouterState state,
            StatefulNavigationShell navigationShell,) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            restorationScopeId: 'home_routes',
            navigatorKey: _sectionANavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                path: '/',
                builder: (BuildContext context, GoRouterState state) =>
                const HomeScreen(),

              ),
            ],
          ),

          // The route branch for the second tab of the bottom navigation bar.
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/task',
                builder: (BuildContext context, GoRouterState state) =>
                const TaskScreen(),
              ),
            ],
          ),

          // The route branch for the third tab of the bottom navigation bar.
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                  path: '/setting',
                  builder: (BuildContext context, GoRouterState state) =>
                  const SettingScreen(),
                 routes: [
                    GoRoute(path: '/theme',builder: (context, state) => const ThemeChangeScreen(),),
                  ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
