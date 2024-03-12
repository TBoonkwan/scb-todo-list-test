import 'package:scb_test/features/todo/data/model/task.dart';
import 'package:scb_test/features/todo/data/model/task_todo_list_model.dart';

abstract class TodoListDataSource {
  Future<TaskTodoListModel> getTodoList();

  Future<bool> createTodoList({
    required Task task,
  });

  Future<bool> deleteTodoList({
    required List<Task> task,
  });

  Future<bool> updateTaskStatus({
    required List<Task> task,
  });
}
