import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:scb_test/features/todo/data/constants/todo_list_constants.dart';
import 'package:scb_test/features/todo/data/model/todo_list_request.dart';
import 'package:scb_test/features/todo/data/model/todo_list_response.dart';
import 'package:scb_test/features/todo/domain/entity/todo_list_ui_model.dart';
import 'package:scb_test/features/todo/domain/mapper/todo_list_mapper.dart';
import 'package:scb_test/features/todo/domain/repository/todo_repository.dart';
import 'package:scb_test/features/todo/domain/usecase/get_todo_list_usecase.dart';

import 'todo_list_usecase_test.mocks.dart';

@GenerateMocks([
  ITodoListRepository,
  TodoListMapper,
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late IGetTodoListUseCase useCase;

  late MockTodoListMapper mockMapper;

  late MockITodoListRepository mockRepository;

  setUp(
    () async {
      mockRepository = MockITodoListRepository();
      mockMapper = MockTodoListMapper();
      useCase = GetTodoListUseCase(
          todoListRepository: mockRepository, mapper: mockMapper);
    },
  );

  group("test get todo list usecase", () {
    test('should return data when get todo list from repository and transform response', () async {
      final String mockResponse = await rootBundle.loadString(
        'assets/mock/todo_list.json',
      );

      final Map<String, dynamic> data = jsonDecode(mockResponse);

      when(mockRepository.getTodoList(request: anyNamed("request"))).thenAnswer(
          (realInvocation) async => TodoListResponse.fromJson(data));

      when(
        mockMapper.map(
          response: anyNamed("response"),
        ),
      ).thenReturn(
        TodoListModel(
          uiModel: [
            TodoListUIModel(
              title: "title",
              taskList: [
                MyTask(id: "id", title: "title", description: "description"),
                MyTask(id: "id", title: "title", description: "description"),
              ],
            ),
            TodoListUIModel(
              title: "title",
              taskList: [
                MyTask(id: "id", title: "title", description: "description"),
              ],
            ),
          ],
          totalPage: 1,
          nextPage: 1,
        ),
      );

      final TodoListModel model = await useCase.getTodoList(
        allTask: [],
        request: TodoListRequest(
          offset: 0,
          limit: 10,
          sortBy: TodoListSortBy.createdAt.value,
          isAsc: true,
          status: TodoListStatus.todo.value,
        ),
      );

      expect(model.uiModel.isNotEmpty, true);
      expect(model.uiModel.length, 2);
      expect(model.uiModel.first.taskList.length, 2);
      expect(model.uiModel.last.taskList.length, 1);

      verify(mockRepository.getTodoList(request: anyNamed("request"))).called(1);
      verify(mockMapper.map(response: anyNamed("response"))).called(1);
    });
  });
}
