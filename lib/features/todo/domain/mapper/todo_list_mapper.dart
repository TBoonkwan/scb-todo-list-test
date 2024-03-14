import 'package:scb_test/extension/date_extension.dart';
import 'package:scb_test/extension/list_extension.dart';
import 'package:scb_test/features/todo/data/model/task.dart';
import 'package:scb_test/features/todo/data/model/todo_list_response.dart';
import 'package:scb_test/features/todo/domain/entity/todo_list_ui_model.dart';

class TodoListMapper {
  TodoListModel map({
    required TodoListResponse response,
  }) {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final DateTime tomorrow = DateTime(now.year, now.month, now.day + 1);

    setupNewCreatedDate(response);

    Map<String?, List<Task>>? taskListGroupByDate = response.task?.groupBy(
      (p0) => p0.createdAt,
    );

    List<TodoListUIModel> uiModel = addTaskToUIModel(
      taskListGroupByDate: taskListGroupByDate,
      today: today,
      tomorrow: tomorrow,
    );

    return TodoListModel(
      nextPage: response.pageNumber ?? 0,
      totalPage: response.totalPages ?? 0,
      uiModel: uiModel,
    );
  }

  void setupNewCreatedDate(TodoListResponse response) {
    response.task?.forEach((element) {
      final DateTime convertStringToDate = DateTime.tryParse(element.createdAt.toString()) ?? DateTime.now();
      final DateTime newDate = DateTime(convertStringToDate.year, convertStringToDate.month, convertStringToDate.day);
      element.createdAt = newDate.toIso8601String();
    });
  }

  List<TodoListUIModel> addTaskToUIModel({
    required Map<String?, List<Task>>? taskListGroupByDate,
    required DateTime today,
    required DateTime tomorrow,
  }) {
    final List<TodoListUIModel> temp = [];

    taskListGroupByDate?.forEach((key, value) {
      final DateTime convertStringToDate =
          DateTime.tryParse(key.toString()) ?? DateTime.now();
      final DateTime createToday = DateTime(
        convertStringToDate.year,
        convertStringToDate.month,
        convertStringToDate.day,
      );

      final String title = getTitleByDate(
        today: today,
        tomorrow: tomorrow,
        createToday: createToday,
        convertStringToDate: convertStringToDate,
      );

      final TodoListUIModel others = TodoListUIModel(
        title: title,
        taskList: [],
      );

      for (var element in value) {
        final MyTask myTask = MyTask(
          id: element.id.toString(),
          title: element.title.toString(),
          description: element.description.toString(),
        );
        others.taskList.add(myTask);
      }
      temp.add(others);
    });

    return temp;
  }

  String getTitleByDate({
    required DateTime today,
    required DateTime tomorrow,
    required DateTime createToday,
    required DateTime convertStringToDate,
  }) {
    Duration isToday = createToday.difference(today);

    String title = '';

    if (isToday.inDays == 0) {
      title = "Today";
    } else {
      if (createToday == tomorrow) {
        title = "Tomorrow";
      } else {
        title = convertStringToDate.formatDate();
      }
    }
    return title;
  }
}
