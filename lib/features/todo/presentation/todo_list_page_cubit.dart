import "package:flutter_bloc/flutter_bloc.dart";
import "package:scb_test/features/todo/data/constants/todo_list_constants.dart";
import "package:scb_test/features/todo/data/model/todo_list_request.dart";
import "package:scb_test/features/todo/domain/entity/todo_list_ui_model.dart";
import "package:scb_test/features/todo/domain/usecase/get_todo_list_usecase.dart";

import "todo_list_page_state.dart";

class TodoListPageCubit extends Cubit<TodoListPageState> {
  IGetTodoListUseCase getTodoListUseCase;

  String currentStatus = TodoListStatus.todo.value;
  num totalPage = 0;
  num nextPage = 0;

  TodoListPageCubit({
    required this.getTodoListUseCase,
  }) : super(const TodoListPageState());

  Future<TodoListModel> fetchTodoList() async =>
      await getTodoListUseCase.getTodoList(
        request: TodoListRequest(
          offset: nextPage,
          limit: 10,
          sortBy: TodoListSortBy.createdAt.value,
          isAsc: true,
          status: currentStatus.toUpperCase(),
        ),
      );

  Future initial({
    required String status,
  }) async {
    nextPage = 0;
    currentStatus = status;

    emit(
      state.copyWith(eventState: TodoListPageEventState.initial),
    );

    final TodoListModel model = await fetchTodoList();

    totalPage = model.totalPage;

    List<TodoListUIModel> uiModel = model.uiModel;

    if (uiModel.isEmpty == true) {
      emit(
        state.copyWith(
          eventState: TodoListPageEventState.noTask,
          taskList: [],
        ),
      );
    } else {
      emit(
        state.copyWith(
          eventState: TodoListPageEventState.update,
          taskList: uiModel,
        ),
      );
    }
  }

  Future loadMoreItem() async {
    if (nextPage == totalPage || state.eventState == TodoListPageEventState.loadMore) {
      return;
    }

    nextPage++;

    emit(
      state.copyWith(
        eventState: TodoListPageEventState.loadMore,
      ),
    );

    final TodoListModel model = await fetchTodoList();

    state.taskList.addAll(model.uiModel);

    emit(
      state.copyWith(
        taskList: state.taskList,
        eventState: TodoListPageEventState.update,
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
        taskList: state.taskList,
        eventState: TodoListPageEventState.update,
      ),
    );

    emit(
      state.copyWith(
        eventState: TodoListPageEventState.none,
      ),
    );
  }

  void reset() {
    emit(const TodoListPageState());
  }
}
