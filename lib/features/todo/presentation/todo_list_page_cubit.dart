import "package:flutter_bloc/flutter_bloc.dart";
import "package:scb_test/features/todo/data/constants/todo_list_constants.dart";
import "package:scb_test/features/todo/data/model/task.dart";
import "package:scb_test/features/todo/data/model/todo_list_request.dart";
import "package:scb_test/features/todo/domain/entity/todo_list_ui_model.dart";
import "package:scb_test/features/todo/domain/usecase/get_todo_list_usecase.dart";

import "todo_list_page_state.dart";

class TodoListPageCubit extends Cubit<TodoListPageState> {
  List<Task> allTask = [];

  IGetTodoListUseCase getTodoListUseCase;

  String currentStatus = TodoListStatus.todo.value;
  num totalPage = 0;
  num nextPage = 0;

  TodoListPageCubit({
    required this.getTodoListUseCase,
  }) : super(const TodoListPageState());

  Future<TodoListModel> fetchTodoList() async =>
      await getTodoListUseCase.getTodoList(
        allTask: allTask,
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
    allTask.clear();
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
          taskList: [],
          eventState: TodoListPageEventState.noTask,
        ),
      );
    } else {
      emit(
        state.copyWith(
          taskList: uiModel,
          eventState: TodoListPageEventState.update,
        ),
      );
    }
  }

  Future loadMoreItem() async {
    if (nextPage == totalPage ||
        state.actionState == TodoListPageActionState.loadMore) {
      return;
    }

    nextPage++;

    emit(
      state.copyWith(
        actionState: TodoListPageActionState.loadMore,
      ),
    );

    final TodoListModel model = await fetchTodoList();

    emit(
      state.copyWith(
        actionState: TodoListPageActionState.none,
      ),
    );

    emit(
      state.copyWith(
        taskList: model.uiModel,
      ),
    );
  }

  void deleteTask({
    required TodoListUIModel uiModel,
    required MyTask task,
  }) async {
    allTask = allTask.where((element) => element.id != task.id).toList();
    emit(
      state.copyWith(
        actionState: TodoListPageActionState.none,
      ),
    );

    uiModel.taskList.remove(task);

    emit(
      state.copyWith(
        taskList: state.taskList,
        actionState: TodoListPageActionState.delete,
      ),
    );
  }

  void reset() {
    emit(const TodoListPageState());
  }

  void navigateToVerifyPasscode() {
    emit(state.copyWith(actionState: TodoListPageActionState.verifyPasscode));
  }

  void navigateToChangePasscode() {
    emit(state.copyWith(actionState: TodoListPageActionState.changePasscode));
  }
}
