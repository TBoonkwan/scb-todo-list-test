import 'dart:convert';

import 'task.dart';

/// task : [{"title":"Title","subtitle":"Subtitle","status":0},{"title":"Title","subtitle":"Subtitle","status":1},{"title":"Title","subtitle":"Subtitle","status":2}]

TaskTodoListModel taskTodoListModelFromJson(String str) =>
    TaskTodoListModel.fromJson(json.decode(str));

String taskTodoListModelToJson(TaskTodoListModel data) =>
    json.encode(data.toJson());

class TaskTodoListModel {
  TaskTodoListModel({
    this.task,
  });

  TaskTodoListModel.fromJson(dynamic json) {
    if (json['task'] != null) {
      task = [];
      json['task'].forEach((v) {
        task?.add(Task.fromJson(v));
      });
    }
  }

  List<Task>? task;

  TaskTodoListModel copyWith({
    List<Task>? task,
  }) =>
      TaskTodoListModel(
        task: task ?? this.task,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (task != null) {
      map['task'] = task?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
