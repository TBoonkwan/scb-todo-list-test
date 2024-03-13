import 'package:scb_test/features/todo/data/model/task.dart';
import 'package:scb_test/features/todo/data/model/todo_list_response.dart';
import 'package:scb_test/features/todo/data/model/todo_list_request.dart';

abstract class TodoListDataSource {
  Future<TodoListResponse> getTodoList({
    required TodoListRequest request,
  });

  Future<bool> deleteTodoList({
    required List<Task> task,
  });
}
