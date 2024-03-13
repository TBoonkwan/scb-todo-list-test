import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:scb_test/features/todo/data/constants/todo_list_constants.dart';
import 'package:scb_test/features/todo/data/model/task.dart';
import 'package:scb_test/features/todo/data/model/todo_list_response.dart';
import 'package:scb_test/features/todo/data/model/todo_list_request.dart';
import 'package:scb_test/features/todo/data/source/todo_list_data_source.dart';

class MockTodoListDataSource extends TodoListDataSource {
  @override
  Future<TodoListResponse> getTodoList({
    required TodoListRequest request,
  }) async {
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
    return TodoListResponse.fromJson(data);
  }

  @override
  Future<bool> deleteTodoList({
    required List<Task> task,
  }) async {
    final storage = GetStorage();
    storage.remove(TodoListKeyConstants.todoListKey);
    storage.write(TodoListKeyConstants.todoListKey,
        TodoListResponse(task: task).toJson());
    return true;
  }
}
