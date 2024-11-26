
import 'package:app_core/app_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_repository/todo_repository.dart';

part 'storage_todo_state.dart';

class TodoStorageCubit extends Cubit<List<TodoModel>> {

  TodoStorageCubit({required TodoRepository todoRepository,
   StorageService? storageService,})
      : _todoRepository = todoRepository,
        _storageService=storageService ?? StorageService(),
        super([]){
    _watchTodo();
  }

  final TodoRepository _todoRepository;
  final StorageService _storageService;
  late final StreamSubscription<bool> _todoSubscription;



  @override
  Future<void> close() async {
    await _unwatchUser();
    return super.close();
  }

  void _onTodoChanged(bool changed)  async {
    if (changed) {
      final todos = await _todoRepository.getSavedTodos();
      emit(todos);
    }
  }
  void _watchTodo() {
    _todoSubscription = _todoRepository.watchTodo.listen(_onTodoChanged);

  }

  Future<void> _unwatchUser() {
    _todoRepository.dispose();
    return _todoSubscription.cancel();

  }

  Future<void> _saveTodos(List<TodoModel> todos) async {
    final todosString = jsonEncode(todos.map((todo) => todo.toJson()).toList());
    await _storageService.savePref('todo', todosString);
  }
  Future<void> toggleTodoStatus(String todo) async {
    final updatedTodos = state.map((element) {
      if (element.todo == todo) {
        return element.copyWith(completed: !element.completed);
      }
      return element;
    }).toList() ;
    emit(updatedTodos);
    await _saveTodos(updatedTodos);
  }



  Future<void> loadTodos() async {
      final todos = await _todoRepository.getSavedTodos();
      emit(todos);
  }


  // Clear all todos
  Future<void> clearTodos() async {
      await _todoRepository.clearSavedTodos();
      emit([]);
  }

  // Clear at index
  Future<void> clearTodo(int index) async {
    state.removeAt(index);
    emit(state);
    await _saveTodos(state);
  }

}
