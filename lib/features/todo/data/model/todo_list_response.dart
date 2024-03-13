import 'task.dart';

/// task : [{"title":"Title","subtitle":"Subtitle","status":0},{"title":"Title","subtitle":"Subtitle","status":1},{"title":"Title","subtitle":"Subtitle","status":2}]

class TodoListResponse {
  List<Task>? task;

  TodoListResponse({
    this.task,
  });

  TodoListResponse.fromJson(dynamic json) {
    if (json['tasks'] != null) {
      task = [];
      json['tasks'].forEach((v) {
        task?.add(Task.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (task != null) {
      map['task'] = task?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
