import 'package:dio/dio.dart';
import 'package:scb_test/features/todo/data/model/task.dart';
import 'package:scb_test/features/todo/data/model/todo_list_request.dart';
import 'package:scb_test/features/todo/data/model/todo_list_response.dart';
import 'package:scb_test/features/todo/data/source/todo_list_data_source.dart';

class RemoteTodoListDataSource extends TodoListDataSource {
  final Dio dio;

  RemoteTodoListDataSource({
    required this.dio,
  });

  @override
  Future<bool> deleteTodoList({
    required List<Task> task,
  }) {
    // TODO: implement deleteTodoList
    throw UnimplementedError();
  }

  @override
  Future<TodoListResponse> getTodoList({
    required TodoListRequest request,
  }) async {
    var response = await dio.get(
      "todo-list",
      queryParameters: request.toJson(),
    );
    return TodoListResponse.fromJson(response.data);
  }
}
