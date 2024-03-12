import "package:equatable/equatable.dart";
import "package:scb_test/features/todo/data/model/task.dart";

class TodoListPageState extends Equatable {
  final TodoListPageEventState? eventState;
  final TodoListPageActionState? actionState;

  final List<Task> taskList;

  const TodoListPageState({
    this.eventState = TodoListPageEventState.loading,
    this.actionState = TodoListPageActionState.none,
    this.taskList = const [],
  });

  @override
  List<Object?> get props => [
        eventState,
        actionState,
        taskList,
      ];

  TodoListPageState copyWith({
    TodoListPageEventState? eventState,
    TodoListPageActionState? actionState,
    List<Task>? taskList,
  }) {
    return TodoListPageState(
      eventState: eventState ?? this.eventState,
      actionState: actionState ?? this.actionState,
      taskList: taskList ?? this.taskList,
    );
  }
}

enum TodoListPageEventState { loading, success }

enum TodoListPageActionState {
  success,
  delete,
  none,
}
