import 'package:scb_test/features/todo/data/model/task.dart';
import 'package:scb_test/features/todo/data/model/task_todo_list_model.dart';
import 'package:scb_test/features/todo/data/source/todo_list_data_source.dart';

class RemoteTodoListDataSource extends TodoListDataSource {
  @override
  Future<bool> createTodoList({
    required Task task,
  }) {
    // TODO: implement createTodoList
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteTodoList({
    required List<Task> task,
  }) {
    // TODO: implement deleteTodoList
    throw UnimplementedError();
  }

  @override
  Future<TaskTodoListModel> getTodoList() {
    // TODO: implement getAllTodoList
    throw UnimplementedError();
  }

  @override
  Future<bool> updateTaskStatus({required List<Task> task}) {
    // TODO: implement updateTaskStatus
    throw UnimplementedError();
  }
}
