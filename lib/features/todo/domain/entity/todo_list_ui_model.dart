class TodoListModel {
  final num nextPage;
  final num totalPage;
  final List<TodoListUIModel> uiModel;

  TodoListModel({
    required this.nextPage,
    required this.totalPage,
    required this.uiModel,
  });
}

class TodoListUIModel {
  final String title;
  final List<MyTask> taskList;

  const TodoListUIModel({
    required this.title,
    required this.taskList,
  });
}

class MyTask {
  final String id;
  final String title;
  final String description;

  MyTask({
    required this.id,
    required this.title,
    required this.description,
  });
}
