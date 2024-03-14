import 'package:scb_test/features/todo/data/model/task.dart';
import 'package:scb_test/features/todo/data/model/todo_list_request.dart';
import 'package:scb_test/features/todo/data/model/todo_list_response.dart';
import 'package:scb_test/features/todo/data/source/todo_list_data_source.dart';
import 'package:scb_test/features/todo/domain/repository/todo_repository.dart';

class TodoListRepository extends ITodoListRepository {
  TodoListDataSource dataSource;

  TodoListRepository({
    required this.dataSource,
  });

  @override
  Future<bool> deleteTodoList({
    required List<Task> task,
  }) async {
    return await dataSource.deleteTodoList(task: task);
  }

  @override
  Future<TodoListResponse> getTodoList({
    required TodoListRequest request,
  }) async {
    return await dataSource.getTodoList(
      request: request,
    );
  }
}
