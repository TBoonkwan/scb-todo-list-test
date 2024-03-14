import "package:equatable/equatable.dart";
import "package:scb_test/features/todo/domain/entity/todo_list_ui_model.dart";

class TodoListPageState extends Equatable {
  final TodoListPageEventState? eventState;
  final TodoListPageActionState? actionState;

  final List<TodoListUIModel> taskList;

  const TodoListPageState({
    this.eventState = TodoListPageEventState.none,
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
    List<TodoListUIModel>? taskList,
  }) {
    return TodoListPageState(
      eventState: eventState ?? this.eventState,
      actionState: actionState ?? this.actionState,
      taskList: taskList ?? this.taskList,
    );
  }
}

enum TodoListPageEventState { initial, noTask, update, none }

enum TodoListPageActionState {
  delete,
  loadMore,
  none,
}
