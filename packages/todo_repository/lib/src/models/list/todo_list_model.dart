import 'package:app_core/app_core.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:todo_repository/todo_repository.dart';

part 'todo_list_model.g.dart';
@JsonSerializable()
class TodoListModel extends Equatable {

   const TodoListModel({
    required this.todos,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory TodoListModel.fromJson(Map<String, dynamic> json) =>
      _$TodoListModelFromJson(json);
  @JsonKey(name: 'todos')
  final List<TodoModel> todos;
  @JsonKey(name: 'total')
  final int total;
  @JsonKey(name: 'skip')
  final int skip;
  @JsonKey(name: 'limit')
  final int limit;

  Map<String, dynamic> toJson() => _$TodoListModelToJson(this);

  static const  none = TodoListModel(todos: [], total: 0, skip: 0, limit: 0);

  @override
  List<Object?> get props => [total,todos,skip,limit];


   TodoListModel copyWith({
     List<TodoModel>? todos,
     int? total,
     int? skip,
     int? limit,
   }) {
     return TodoListModel(
       todos: todos ?? this.todos,
       total: total ?? this.total,
       skip: skip ?? this.skip,
       limit: limit ?? this.limit,
     );
   }

}
extension TodoListExtensions on TodoListModel {
  bool get isNone => this == TodoListModel.none;
}
