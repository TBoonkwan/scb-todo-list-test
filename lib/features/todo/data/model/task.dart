import 'dart:convert';

/// title : "Title"
/// description : "Subtitle"
/// status : 0

Task taskFromJson(String str) => Task.fromJson(json.decode(str));

String taskToJson(Task data) => json.encode(data.toJson());

class Task {
  String? id;
  String? title;
  String? description;
  String? status;

  Task({
    this.id,
    this.title,
    this.description,
    this.status,
  });

  Task.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['status'] = status;
    return map;
  }
}
