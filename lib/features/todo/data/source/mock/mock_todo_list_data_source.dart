import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:scb_test/features/todo/data/constants/todo_list_key_constants.dart';
import 'package:scb_test/features/todo/data/model/task.dart';
import 'package:scb_test/features/todo/data/model/task_todo_list_model.dart';
import 'package:scb_test/features/todo/data/source/todo_list_data_source.dart';

class MockTodoListDataSource extends TodoListDataSource {
  @override
  Future<TaskTodoListModel> getTodoList() async {
    final storage = GetStorage();
    final Map<String, dynamic> data;
    if (storage.hasData(TodoListKeyConstants.todoListKey)) {
      data = storage.read(TodoListKeyConstants.todoListKey);
    } else {
      final String response = await rootBundle.loadString(
        'assets/mock/todo_list.json',
      );
      data = jsonDecode(response);
      storage.write(TodoListKeyConstants.todoListKey, data);
    }
    return TaskTodoListModel.fromJson(data);
  }

  @override
  Future<bool> createTodoList({
    required Task task,
  }) async {
    final storage = GetStorage();
    final Map<String, dynamic> data = storage.read(TodoListKeyConstants.todoListKey);
    final TaskTodoListModel model = TaskTodoListModel.fromJson(data);
    model.task?.add(task);
    int index = 0;
    model.task?.forEach((element) {
      index++;
      element.id = index;
    });
    storage.remove(TodoListKeyConstants.todoListKey);
    storage.write(TodoListKeyConstants.todoListKey, model.toJson());
    return true;
  }

  @override
  Future<bool> deleteTodoList({
    required List<Task> task,
  }) async {
    final storage = GetStorage();
    storage.remove(TodoListKeyConstants.todoListKey);
    storage.write(TodoListKeyConstants.todoListKey, TaskTodoListModel(task: task).toJson());
    return true;
  }

  @override
  Future<bool> updateTaskStatus({required List<Task> task}) async {
    final storage = GetStorage();
    storage.remove(TodoListKeyConstants.todoListKey);
    storage.write(TodoListKeyConstants.todoListKey, TaskTodoListModel(task: task).toJson());
    return true;
  }
}
