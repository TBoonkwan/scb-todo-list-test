import 'dart:convert';

/// title : "Title"
/// description : "Subtitle"
/// status : 0

Task taskFromJson(String str) => Task.fromJson(json.decode(str));

String taskToJson(Task data) => json.encode(data.toJson());

class Task {
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

  num? id;

  String? title;
  String? description;
  num? status;

  Task copyWith({
    num? id,
    String? title,
    String? description,
    num? status,
  }) =>
      Task(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        status: status ?? this.status,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['status'] = status;
    return map;
  }
}
