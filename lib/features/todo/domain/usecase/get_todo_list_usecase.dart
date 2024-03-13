import 'package:scb_test/features/todo/data/model/todo_list_request.dart';
import 'package:scb_test/features/todo/data/model/todo_list_response.dart';
import 'package:scb_test/features/todo/domain/entity/todo_list_ui_model.dart';
import 'package:scb_test/features/todo/domain/mapper/todo_list_mapper.dart';
import 'package:scb_test/features/todo/domain/repository/todo_repository.dart';

abstract class IGetTodoListUseCase {
  Future<List<TodoListUIModel>> getTodoList({
    required TodoListRequest request,
  });
}

class GetTodoListUseCase extends IGetTodoListUseCase {
  final ITodoListRepository todoListRepository;
  final TodoListMapper mapper;

  GetTodoListUseCase({
    required this.todoListRepository,
    required this.mapper,
  });

  @override
  Future<List<TodoListUIModel>> getTodoList({
    required TodoListRequest request,
  }) async {
    final TodoListResponse response = await todoListRepository.getTodoList(request: request);
    final List<TodoListUIModel> uiModel = mapper.map(response: response);
    return uiModel;
  }
}
