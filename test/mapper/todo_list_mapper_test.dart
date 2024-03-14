import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:scb_test/features/todo/data/model/todo_list_response.dart';
import 'package:scb_test/features/todo/domain/entity/todo_list_ui_model.dart';
import 'package:scb_test/features/todo/domain/mapper/todo_list_mapper.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late TodoListMapper todoListMapper;

  setUp(
    () async {
      todoListMapper = TodoListMapper();
    },
  );

  group("test transform response to ui model", () {
    test('should return ui model after group by createdAt', () async {
      final String mockResponse = await rootBundle.loadString(
        'assets/mock/todo_list.json',
      );

      final Map<String, dynamic> data = jsonDecode(mockResponse);

      final TodoListModel model = todoListMapper.map(response: TodoListResponse.fromJson(data));

      expect(model.nextPage, 0);
      expect(model.totalPage, 0);
      expect(model.uiModel.isNotEmpty, true);

      expect(model.uiModel.first.title, "24 Mar 2023");
      expect(model.uiModel.first.taskList.isNotEmpty, true);
      expect(model.uiModel.first.taskList.length, 2);

      expect(model.uiModel.last.title, "25 Mar 2023");
      expect(model.uiModel.last.taskList.isNotEmpty, true);
      expect(model.uiModel.last.taskList.length, 1);
    });
  });
}
