class TodoListRequest {
  final num offset;
  final num limit;
  final String sortBy;
  final bool isAsc;
  final String status;

  TodoListRequest({
    required this.offset,
    required this.limit,
    required this.sortBy,
    required this.isAsc,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['offset'] = offset;
    map['limit'] = limit;
    map['sortBy'] = sortBy;
    map['isAsc'] = isAsc;
    map['status'] = status;
    return map;
  }
}
