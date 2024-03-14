class TodoListKeyConstants {
  static String todoListKey = "todo_list";
}

enum TodoListStatus {
  todo("TODO"),
  doing("DOING"),
  done("DONE");

  final String value;

  const TodoListStatus(this.value);
}

enum TodoListSortBy {
  createdAt("createdAt");

  final String value;

  const TodoListSortBy(this.value);
}

enum TodoListOrderBy {
  asc("asc"),
  desc("desc");

  final String value;

  const TodoListOrderBy(this.value);
}
