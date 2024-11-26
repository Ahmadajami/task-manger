

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manger_app/app/extensions.dart';
import 'package:task_manger_app/routing/fab_cubit/fab_cubit.dart';

import 'package:task_manger_app/todo/cubit/storage_todo_cubit.dart';
import 'package:todo_repository/todo_repository.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
      return BlocProvider<TodoStorageCubit>(
        create:(context) => TodoStorageCubit(
          todoRepository: context.read<TodoRepository>(),)..
        loadTodos(),

        child: const HomeContent(),
      );
  }
}
class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final _scrollController = ScrollController();
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Track the last visibility state trying to minimize change
    bool lastFabVisibility = true;
    _scrollController.addListener(() {
      final bool isFabVisible = _scrollController.position.pixels <= 100;
      if (isFabVisible != lastFabVisibility) {
        context.read<FabCubit>().updateFabVisibility(isVisible: isFabVisible);
        lastFabVisibility = isFabVisible; // Update the tracked visibility
      }

    },);
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoStorageCubit,List<TodoModel>>(
      builder: (context, state) {
         return state.isEmpty ?   Center(
           child: Text('Nothing in Storage',
             style: TextStyle(
                 fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize
             ,),
           ),
         ): Padding(
           padding: const EdgeInsets.all(8),
           child: ListView.separated(
             controller: _scrollController,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key:  Key(state[index].todo),
                    onDismissed: (direction) {
                      context.read<TodoStorageCubit>().clearTodo(index);
                      context.showSnackBar(
                          text: 'Deleted Successfully',
                          backgroundColor: Colors.red,);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Card(
                        shape:const  RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(50),
                                topRight: Radius.circular(50)
                            ,)
                        ,),
                        elevation: 10,
                        child: CheckboxListTile(
                          value: state[index].completed,
                          title: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme.titleLarge?.fontSize,
                                color: state[index].completed
                                    ? Theme.of(context).listTileTheme.textColor
                                    : Colors.red,
                              ),
                              state[index].todo,
                            ),
                          ), onChanged: (bool? value) {
                          context.read<TodoStorageCubit>().
                          toggleTodoStatus( state[index].todo);
                        },

                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: state.length,),
         );

    }
    ,);
  }
}
