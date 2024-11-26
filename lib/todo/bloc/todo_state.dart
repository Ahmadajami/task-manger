part of 'todo_bloc.dart';

enum TodoStatus { initial, loading, failure, success }

extension TodoStatusExtensions on TodoStatus {
  bool get isInitial => this == TodoStatus.initial;
  bool get isLoading => this == TodoStatus.loading;
  bool get isSuccess => this == TodoStatus.success;
  bool get isFailure => this == TodoStatus.failure;
}

final class TodoState extends Equatable {
  // Private named constructor
  const TodoState._({
    required this.status,
    this.todos = TodoListModel.none,
    this.failure = TodoFailure.none,
    this.hasReachedMax = false,
  });

  // Named constructors
  const TodoState.initial()
      : this._(status: TodoStatus.initial);

  const TodoState.loading(TodoListModel todos)
      : this._(status: TodoStatus.loading, todos: todos);

  const TodoState.success({
    required TodoListModel todos,
    required bool hasReachedMax,
  }) : this._(
    status: TodoStatus.success,
    todos: todos,
    hasReachedMax: hasReachedMax,
  );

  const TodoState.failure(TodoFailure failure)
      : this._(status: TodoStatus.failure, failure: failure);

  const TodoState.updated({required TodoListModel todos})
      : this._(status: TodoStatus.success, todos: todos);

  // Properties
  final TodoStatus status;
  final TodoListModel todos;
  final TodoFailure failure;
  final bool hasReachedMax;

  // State extensions
  bool get isInitial => status.isInitial;
  bool get isLoading => status.isLoading;
  bool get isSuccess => status.isSuccess;
  bool get isFailure => status.isFailure;

  // Copy with method for immutability
  TodoState copyWith({
    TodoStatus? status,
    TodoListModel? todos,
    TodoFailure? failure,
    bool? hasReachedMax,
  }) {
    return TodoState._(
      status: status ?? this.status,
      todos: todos ?? this.todos,
      failure: failure ?? this.failure,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [
    status,
    todos,
    todos.todos,
    failure,
    hasReachedMax,
  ];
}
