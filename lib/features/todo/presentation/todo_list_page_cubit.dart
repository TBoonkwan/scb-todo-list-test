import "package:flutter_bloc/flutter_bloc.dart";
import "package:scb_test/features/todo/data/constants/todo_list_constants.dart";
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
      state.copyWith(eventState: TodoListPageEventState.initial),
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
        eventState: TodoListPageEventState.loaded,
      ),
    );
  }

  void deleteTask({
    required TodoListUIModel uiModel,
    required MyTask task,
  }) async {
    uiModel.taskList.remove(task);

    emit(
      state.copyWith(
        eventState: TodoListPageEventState.deleted,
        taskList: state.taskList,
      ),
    );

    emit(
      state.copyWith(
        eventState: TodoListPageEventState.loaded,
      ),
    );
  }

  void reset() {
    emit(const TodoListPageState());
  }
}
