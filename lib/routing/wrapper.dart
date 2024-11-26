import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manger_app/routing/fab_cubit/fab_cubit.dart';
// ignore_for_file: omit_local_variable_types
class ScaffoldWithNavBar extends StatelessWidget {
  /// Constructs an [ScaffoldWithNavBar].
  const ScaffoldWithNavBar({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FabCubit>(
  create: (context) => FabCubit(),
  child: ScaffoldWithNavBarContent(navigationShell: navigationShell,),
);
  }


}
class ScaffoldWithNavBarContent extends StatelessWidget {
  const ScaffoldWithNavBarContent({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      floatingActionButton:navigationShell.currentIndex== 0 ?
      BlocBuilder<FabCubit, FabState>(
  builder: (context, state) {
    return  state.isFabVisible ?
    FloatingActionButton(
        elevation: 10,
        child: const Icon(Icons.task)
        , onPressed: (){
        context.go('/add-todo');
      },) :
    const SizedBox();
  },
) : null,
      appBar: navigationShell.currentIndex == 2
          ? AppBar(
        leading: _buildLeadingButton(context),
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        title: const Text('Setting'),
        centerTitle: true,
      )
          : navigationShell.currentIndex == 0 ? AppBar(
        leading: _buildLeadingButton(context),
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        title: const Text('Local Todo'),
        centerTitle: true,
      ):null,
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Theme.of(context).unselectedWidgetColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Local Todo',
            tooltip: 'Todo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.online_prediction),
            label: 'online_Todo',
            tooltip: 'Todo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
            tooltip: 'Setting Screen',),
        ],
        currentIndex: navigationShell.currentIndex,
        onTap: (int index) => _onTap(context, index),
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
  Widget? _buildLeadingButton(BuildContext context) {

    final RouteMatchList currentConfiguration =
        GoRouter.of(context).routerDelegate.currentConfiguration;

    final RouteMatch lastMatch = currentConfiguration.last;

    final Uri location = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches.uri
        : currentConfiguration.uri;

    final bool canPop = location.pathSegments.length > 1;
    return canPop ? BackButton(onPressed: GoRouter.of(context).pop) : null;
  }
}
