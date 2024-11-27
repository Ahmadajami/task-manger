
import 'package:api_client/api_client.dart';
import 'package:app_core/app_core.dart';
import 'package:todo_repository/src/failures.dart';
import 'package:todo_repository/src/models/list/todo_list_model.dart';
import 'package:todo_repository/src/models/todo_model.dart';

class _TodoRepositoryConstants {
  static const String todoKey = 'todo';
}

class TodoRepository {
  TodoRepository({
    required ApiClient client,
    StorageService? storage,
  })  : _client = client,
        _storageService = storage ?? StorageService();

  final ApiClient _client;
  final StorageService _storageService;
  final StreamController<bool> _onChangeController =
  StreamController<bool>.broadcast();

  Stream<bool> get watchTodo => _onChangeController.stream;

  void _updateTodoStream(bool value) {
    _onChangeController.add(value);
  }
  void dispose() {
    _onChangeController.close();
  }


  Future<TodoListModel> getTodos({required int skip, int limit = 20}) async {
    try {
      final todos = await _client.getTodos(limit, skip);
      return todos;
    } on DioException {
      throw TodoFailure.fromGetTodoList();
    }
  }





  Future<TodoModel> updateTodo({
    required String id,
    required TodoModel todo,
  }) async {
    try {
      final updatedTodo = await _client.updateTodo(id, todo);
      return updatedTodo;
    } on DioException {
      throw TodoFailure.fromUpdate();
    }
  }


  Future<TodoModel> createTodo({required TodoModel todo}) async {
    try {
      final createdTodo = await _client.createTodo(todo);
      await _addAndSaveTodoToStorage(createdTodo);
      return createdTodo;
    } on DioException {
      throw TodoFailure.fromCreate();
    }
  }


  Future<void> _addAndSaveTodoToStorage(TodoModel newTodo) async {
    final todos = await _fetchSavedTodos();
    todos.add(newTodo);

    final updatedTodosJson =
    jsonEncode(todos.map((todo) => todo.toJson()).toList());
    await _storageService.
    savePref(_TodoRepositoryConstants.todoKey, updatedTodosJson);
    _updateTodoStream(true);

  }


  Future<List<TodoModel>> getSavedTodos() async {
    return _fetchSavedTodos();
  }


  Future<List<TodoModel>> _fetchSavedTodos() async {
    final todosJson = await
    _storageService.readPrefs(_TodoRepositoryConstants.todoKey);
    if (todosJson == null) {
      return [];
    }

    final jsonList = jsonDecode(todosJson) as List<dynamic>;
    return jsonList.map((json) =>
        TodoModel.fromJson(json as Map<String, dynamic>),).toList();
  }

  /// Toggle the completion state of a todo by its todo String.
  Future<void> toggleTodo({
    required String todo,
  }) async {
    try {
      final todos = await _fetchSavedTodos();
      final todoIndex = todos.indexWhere((t) => t.todo == todo);

      if (todoIndex != -1) {
        final  todo = todos[todoIndex];
        final toggledTodo=todo.copyWith(completed: !todo.completed);

        // Update the list and save it back to storage
        todos[todoIndex] = toggledTodo;
        final updatedTodosJson =
        jsonEncode(todos.map((todo) => todo.toJson()).toList());
        await _storageService.
        savePref(_TodoRepositoryConstants.todoKey, updatedTodosJson);
        _updateTodoStream(true);

      } else {
        throw TodoFailure.fromToggleTodoNotFound();
      }
    } catch (e) {
      throw TodoFailure.fromToggleTodo();
    }
  }



  Future<void> clearSavedTodos() async {
    await _storageService.
    savePref(_TodoRepositoryConstants.todoKey, jsonEncode([]));

  }
}
