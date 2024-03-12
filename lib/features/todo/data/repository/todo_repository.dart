import 'package:scb_test/features/todo/data/model/task.dart';
import 'package:scb_test/features/todo/data/model/task_todo_list_model.dart';
import 'package:scb_test/features/todo/data/source/todo_list_data_source.dart';
import 'package:scb_test/features/todo/domain/repository/todo_repository.dart';

class TodoListRepository extends ITodoListRepository {
  TodoListDataSource dataSource;

  TodoListRepository({
    required this.dataSource,
  });

  @override
  Future<bool> createTodoList({
    required Task task,
  }) async {
    return await dataSource.createTodoList(task: task);
  }

  @override
  Future<bool> deleteTodoList({
    required List<Task> task,
  }) async {
    return await dataSource.deleteTodoList(task: task);
  }

  @override
  Future<TaskTodoListModel> getTodoList() async {
    return await dataSource.getTodoList();
  }

  @override
  Future<bool> updateTaskStatus({required List<Task> task}) async {
    return await dataSource.updateTaskStatus(task: task);
  }
}
