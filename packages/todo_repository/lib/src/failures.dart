import 'package:app_core/app_core.dart';

class TodoFailure extends Failure {
  const TodoFailure._();
  factory TodoFailure.fromGetTodoList() => const PageFailure();
  factory TodoFailure.fromUpdate() => const UpdateFailure();
  factory TodoFailure.fromCreate() => const CreateFailure();
  factory  TodoFailure.fromToggleTodoNotFound() =>const NotFound();
  factory  TodoFailure.fromToggleTodo() =>const ToggleFailure();

  static const none = TodoNoFailure();
}
class TodoNoFailure extends TodoFailure {
  const TodoNoFailure() : super._();
}

class PageFailure extends TodoFailure{
  const PageFailure(): super._();
}
class NotFound extends TodoFailure{
  const NotFound(): super._();
}
class ToggleFailure extends TodoFailure{
  const ToggleFailure(): super._();
}
class EndListFailure extends TodoFailure{
  const EndListFailure() : super._();

}
class UpdateFailure extends TodoFailure{
  const UpdateFailure() : super._();
}

class CreateFailure extends TodoFailure{
  const CreateFailure() : super._();
}

extension TodoFailureExtension on TodoFailure{
  bool get isPageFailure  => this is PageFailure;
  bool get isEndListFailure  => this is EndListFailure;
}
