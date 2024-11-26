

part of 'storage_todo_cubit.dart';
extension TodoStorageStateDetection on TodoStorageState {
  bool get isLoading => this is TodoStorageLoading;

  bool get isLoaded => this is TodoStorageLoaded;

  bool get isError => this is TodoStorageError;


  String? get errorMessage {
    if (this is TodoStorageError) {
      return (this as TodoStorageError).message;
    }
    return null;
  }
}

abstract class TodoStorageState extends Equatable {
  const TodoStorageState();

  @override
  List<Object> get props => [];
}

class TodoStorageInitial extends TodoStorageState {}

class TodoStorageLoading extends TodoStorageState {}

class TodoStorageLoaded extends TodoStorageState {

  const TodoStorageLoaded({required this.todos});
  final List<TodoModel> todos;

  @override
  List<Object> get props => [todos,];
}

class TodoStorageError extends TodoStorageState {

  const TodoStorageError({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}
