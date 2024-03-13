import 'package:scb_test/features/todo/data/model/todo_list_response.dart';
import 'package:scb_test/features/todo/domain/entity/todo_list_ui_model.dart';

class TodoListMapper {
  @override
  List<TodoListUIModel> map({required TodoListResponse response}) {
    return [
      TodoListUIModel(
        title: "Today",
        taskList: [
          MyTask(
            id: "id",
            title: "title",
            description: "description",
          ),
        ],
      ),
      TodoListUIModel(
        title: "Tomorrow",
        taskList: [
          MyTask(
            id: "id",
            title: "title",
            description: "description",
          ),
          MyTask(
            id: "id",
            title: "title",
            description: "description",
          ),
        ],
      ),
    ];
  }
}
