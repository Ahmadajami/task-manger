part of 'todo_bloc.dart';


sealed class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

final class TodosListRequested extends TodoEvent {
  const TodosListRequested();
}

final class TodoComplete extends TodoEvent{
  const TodoComplete({required this.todo});
  final TodoModel todo;
}
final class TodoCreate extends TodoEvent{
  const TodoCreate( {
    required this.failureCallBack,
    required this.successCallBack,
    required this.todo,
  });
  final TodoModel todo;
  final VoidCallback successCallBack;
  final VoidCallback failureCallBack;
}

final class TodosStorageListRequested extends TodoEvent {
  const TodosStorageListRequested();
}
