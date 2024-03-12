import "package:flutter_bloc/flutter_bloc.dart";
import "package:scb_test/features/todo/data/model/task.dart";
import "package:scb_test/features/todo/domain/repository/todo_repository.dart";

import "todo_list_page_state.dart";

class TodoListPageCubit extends Cubit<TodoListPageState> {
  ITodoListRepository todoListRepository;

  TodoListPageCubit({
    required this.todoListRepository,
  }) : super(const TodoListPageState());

  Future getTodoList() async {
    emit(
      state.copyWith(eventState: TodoListPageEventState.loading),
    );

    final response = await todoListRepository.getTodoList();

    await Future.delayed(
      const Duration(
        milliseconds: 300,
      ),
    );

    emit(
      state.copyWith(
        taskList: response.task ?? [],
        eventState: TodoListPageEventState.success,
      ),
    );
  }

  void deleteTask({
    required Task task,
  }) async {
    final List<Task> newTaskList = state.taskList + [];

    newTaskList.remove(task);

    await todoListRepository.deleteTodoList(task: newTaskList);

    emit(state.copyWith(
      taskList: newTaskList,
    ));
  }
}
