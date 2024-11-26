
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manger_app/app/extensions.dart';
import 'package:task_manger_app/todo/bloc/todo_bloc.dart';
import 'package:todo_repository/todo_repository.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>  TodoBloc(
      todoRepository: context.read<TodoRepository>(),
    )..add(
      const TodosListRequested(),
    ),
      child: const TodoContent(),
    );
  }
}

class TodoContent extends StatefulWidget {
  const TodoContent({super.key});

  @override
  State<TodoContent> createState() => _TodoContentState();
}

class _TodoContentState extends State<TodoContent> {
  final _scrollController = ScrollController();
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<TodoBloc>().add(
            const TodosListRequested(),
          );
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<TodoBloc, TodoState>(
        builder: (context, state) {
          if(state.isLoading){
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status.isFailure && !state.failure.isEndListFailure) {
            return Center(
              child: TextButton(
                onPressed: () {
                  context.read<TodoBloc>().add(
                        const TodosListRequested(),
                      );
                },
                child: const Text('Something Went Wrong Try to  Refresh'),
              ),
            );
          }
          if (state.status.isSuccess) {
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (BuildContext context, int index) {
                return index >= state.todos.todos.length
                    ? bottomLoader()
                    : Padding(
                        padding: const EdgeInsets.all(8),
                        child: Card(

                          shape:const  RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                            )
                          ,),
                          elevation: 10,
                          child: CheckboxListTile(
                            value: state.todos.todos[index].completed,
                            title: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                style: TextStyle(
                                  fontSize:
                                  Theme.of(context).textTheme.
                                  titleLarge?.fontSize,
                                  color: state.todos.todos[index].completed
                                      ? Theme.of(context).
                                  listTileTheme.textColor
                                      : Colors.red,
                                ),
                                state.todos.todos[index].todo,
                              ),
                            ), onChanged: (bool? value) {
                              context.read<TodoBloc>().add(
                                  TodoComplete(todo: state.todos.todos[index])
                              ,);
                          },

                          ),
                        ),
                      );
              },
              itemCount: state.hasReachedMax
                  ? state.todos.todos.length
                  : state.todos.todos.length + 1,
              controller: _scrollController,
            );
          }
          return Container();
        },
        listener: (BuildContext context, TodoState state) {
          if (state.isFailure && state.failure.isPageFailure) {
            context.showSnackBar(
              text: 'Something Went Wrong!',
              backgroundColor: Colors.red,
            );
          }
        },
      ),
    );
  }
}

Widget bottomLoader() {
  return const Center(
    child: SizedBox(
      height: 24,
      width: 24,
      child: CircularProgressIndicator(strokeWidth: 1.5),
    ),
  );
}
