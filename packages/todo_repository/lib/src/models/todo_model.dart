import 'package:app_core/app_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo_model.g.dart';

@JsonSerializable()
class TodoModel extends Equatable {
  const TodoModel({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      _$TodoModelFromJson(json);

  @JsonKey(name: 'id', fromJson: _idFromJson, toJson: _idToJson)
  final String? id;
  @JsonKey(name: 'todo')
  final String todo;
  @JsonKey(name: 'completed')
  final bool completed;
  @JsonKey(name: 'userId')
  final int userId;

  Map<String, dynamic> toJson() => _$TodoModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        todo,
        completed,
        userId,
      ];

  static const none = TodoModel(
    id: '0',
    todo: 'none',
    completed: false,
    userId: 0,
  );
  TodoModel copyWith({
    String? id,
    String? todo,
    bool? completed,
    int? userId,
  }) {
    return TodoModel(
      id: id ?? this.id,
      todo: todo ?? this.todo,
      completed: completed ?? this.completed,
      userId: userId ?? this.userId,
    );
  }



  static String? _idFromJson(dynamic id) {
    if (id is int) {
      return id.toString();
    } else if (id is String) {
      return id;
    }
    return null;
  }


  static dynamic _idToJson(String? id) {
    if (id == null) {
      return null;
    }
    return id;
  }
}

extension TodoExtensions on TodoModel {
  bool get isNone => this == TodoModel.none;
}
