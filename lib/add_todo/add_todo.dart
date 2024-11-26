
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manger_app/app/extensions.dart';
import 'package:task_manger_app/todo/bloc/todo_bloc.dart';

import 'package:todo_repository/todo_repository.dart';
import 'package:user_repository/user_repository.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoBloc>(
      create: (context) =>
          TodoBloc(todoRepository: context.read<TodoRepository>()),
      child: const AddTodoContent(),
    );
  }
}


class AddTodoContent extends StatefulWidget {
  const AddTodoContent({super.key});

  @override
  State<AddTodoContent> createState() => _AddTodoContentState();
}

class _AddTodoContentState extends State<AddTodoContent> with RestorationMixin {
  final _todoController = RestorableTextEditingController();
  final _completed = RestorableBool(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Todo'),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      'Todo.',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _todoController.value,
                      decoration: const InputDecoration(
                        hintText: 'Todo',
                      ),
                    ),
                    const SizedBox(height: 15),
                    CheckboxListTile(
                      selected: _completed.value,
                      title: const Text('Completed'),
                      value: _completed.value,
                      onChanged: (value) {
                        setState(() {
                          _completed.value = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: state.isLoading ? null : () {
                        final user = context
                            .read<UserRepository>()
                            .currentUser;
                        final todo = TodoModel(id: null,
                          todo: _todoController.value.text,
                          completed: _completed.value, userId: user.id,);
                        context.read<TodoBloc>().add(
                            TodoCreate(
                                todo: todo,
                              failureCallBack: () {
                                context
                                    .showSnackBar(
                                  text: 'Something Went Wrong!',
                                  backgroundColor: Colors.red,);
                              },
                              successCallBack: () {
                                context
                                    ..showSnackBar(
                                  text: 'Todo Added Successfully!',
                                  backgroundColor: Colors.teal,)
                                    ..pop();
                              } ,
                            )
                        ,);

                      },
                      child: const Text(
                        'Add Todo',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  String? get restorationId => 'add_todo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_completed, 'completed');
    registerForRestoration(_todoController, 'todo');
  }
}
