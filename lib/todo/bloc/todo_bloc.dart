import 'dart:ui';

import 'package:app_core/app_core.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:todo_repository/todo_repository.dart';

part 'todo_event.dart';
part 'todo_state.dart';

const Duration throttleDuration = Duration(milliseconds: 100);

// Utility for throttling events
EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) =>
      droppable<E>().call(events.throttle(duration), mapper);
}

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc({required TodoRepository todoRepository})
      : _todoRepository = todoRepository,
        super(const TodoState.initial()) {
    on<TodoCreate>(_onTodoCreate);
    on<TodoComplete>(_onTodoComplete);
    on<TodosListRequested>(
      _onTodosListRequested,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final TodoRepository _todoRepository;


  Future<void> _onTodoCreate(TodoCreate event, Emitter<TodoState> emit) async {
    try {
      emit(TodoState.loading(state.todos));
      await _todoRepository.createTodo(todo: event.todo);
      emit(TodoState.success(
          todos: state.todos,
          hasReachedMax: state.hasReachedMax,),);
      event.successCallBack();
    } on TodoFailure catch (failure) {
      emit(TodoState.failure(failure));
      event.failureCallBack();

    }
  }


  Future<void> _onTodosListRequested(
      TodosListRequested event,
      Emitter<TodoState> emit,
      ) async {
    if (state.hasReachedMax) return;

    try {
      final newTodos = await
      _todoRepository.getTodos(skip: state.todos.todos.length);

      emit(
        TodoState.success(
          todos: newTodos.todos.isEmpty
              ? state.todos
              : state.todos.copyWith(
            todos: [...state.todos.todos, ...newTodos.todos],
            skip: state.todos.todos.length,
          ),
          hasReachedMax: newTodos.todos.isEmpty,
        ),
      );
    } on TodoFailure catch (failure) {
      emit(TodoState.failure(failure));
    }
  }


  Future<void> _onTodoComplete(TodoComplete event, Emitter<TodoState> emit)
  async {
    try {
      final updatedTodo = await _todoRepository.updateTodo(
        id: event.todo.id!,
        todo: event.todo.copyWith(completed: !event.todo.completed),
      );

      final updatedList = _replaceTodoById(
        todos: state.todos.todos,
        id: updatedTodo.id!,
        newTodo: updatedTodo,
      );

      emit(TodoState.updated(todos: state.todos.copyWith(todos: updatedList)));
    } on TodoFailure catch (failure) {
      emit(TodoState.failure(failure));
    }
  }


  List<TodoModel> _replaceTodoById({
    required List<TodoModel> todos,
    required String id,
    required TodoModel newTodo,
  }) {
    return todos.map((todo) => todo.id == id ? newTodo : todo).toList();
  }
}
