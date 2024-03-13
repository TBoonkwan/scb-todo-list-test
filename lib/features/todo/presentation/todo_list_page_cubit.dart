import "package:flutter_bloc/flutter_bloc.dart";
import "package:scb_test/features/todo/data/constants/todo_list_constants.dart";
import "package:scb_test/features/todo/data/model/task.dart";
import "package:scb_test/features/todo/data/model/todo_list_request.dart";
import "package:scb_test/features/todo/domain/entity/todo_list_ui_model.dart";
import "package:scb_test/features/todo/domain/usecase/get_todo_list_usecase.dart";

import "todo_list_page_state.dart";

class TodoListPageCubit extends Cubit<TodoListPageState> {
  IGetTodoListUseCase getTodoListUseCase;

  TodoListPageCubit({
    required this.getTodoListUseCase,
  }) : super(const TodoListPageState());

  Future getTodoList({
    required String status,
  }) async {
    emit(
      state.copyWith(eventState: TodoListPageEventState.loading),
    );

    final uiModel = await getTodoListUseCase.getTodoList(
      request: TodoListRequest(
        offset: 0,
        limit: 10,
        sortBy: TodoListSortBy.createdAt.value,
        isAsc: true,
        status: status.toUpperCase(),
      ),
    );

    emit(
      state.copyWith(
        taskList: uiModel,
        eventState: TodoListPageEventState.success,
      ),
    );
  }

  void deleteTask({
    required MyTask task,
  }) async {
    // final List<Task> newTaskList = state.taskList + [];
    //
    // newTaskList.remove(task);
    //
    // emit(
    //   state.copyWith(
    //     taskList: newTaskList,
    //   ),
    // );
    //
    // await getTodoListUseCase.deleteTodoList(task: newTaskList);
  }

  void reset() {
    emit(const TodoListPageState());
  }
}
