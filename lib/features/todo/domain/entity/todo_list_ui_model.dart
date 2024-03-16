import 'package:equatable/equatable.dart';

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

class TodoListUIModel extends Equatable{
  final String title;
  final List<MyTask> taskList;

  const TodoListUIModel({
    required this.title,
    required this.taskList,
  });

  @override
  List<Object?> get props =>[title,taskList];
}

class MyTask extends Equatable{
  final String id;
  final String title;
  final String description;

  MyTask({
    required this.id,
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [id,title,description];
}
