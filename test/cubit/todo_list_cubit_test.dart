import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:scb_test/features/todo/data/constants/todo_list_constants.dart';
import 'package:scb_test/features/todo/domain/entity/todo_list_ui_model.dart';
import 'package:scb_test/features/todo/domain/usecase/get_todo_list_usecase.dart';
import 'package:scb_test/features/todo/presentation/todo_list_page_cubit.dart';
import 'package:scb_test/features/todo/presentation/todo_list_page_state.dart';

import 'todo_list_cubit_test.mocks.dart';

@GenerateMocks([
  IGetTodoListUseCase,
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late TodoListPageCubit pageCubit;

  late MockIGetTodoListUseCase mockUseCase;

  setUp(
    () async {
      mockUseCase = MockIGetTodoListUseCase();
      pageCubit = TodoListPageCubit(
        getTodoListUseCase: mockUseCase,
      );
    },
  );

  group("test get todo list cubit", () {
    test('should return data when get todo list from usecase', () async {
      final TodoListModel todoListModel = TodoListModel(
        nextPage: 1,
        totalPage: 1,
        uiModel: [
          TodoListUIModel(
            title: "Today",
            taskList: [
              MyTask(
                id: "id",
                title: "title",
                description: "description",
              )
            ],
          )
        ],
      );

      when(
        mockUseCase.getTodoList(
          request: anyNamed("request"),
          allTask: anyNamed("allTask"),
        ),
      ).thenAnswer((_) async => todoListModel);

      expect(pageCubit.state.eventState, TodoListPageEventState.none);

      await pageCubit.initial(status: TodoListStatus.todo.value);

      verify(mockUseCase.getTodoList(
              allTask: anyNamed("allTask"), request: anyNamed("request")))
          .called(1);

      expect(pageCubit.currentStatus, TodoListStatus.todo.value);

      expect(pageCubit.state.eventState, TodoListPageEventState.update);

      expect(
        pageCubit.state.taskList.isNotEmpty,
        todoListModel.uiModel.isNotEmpty == true,
      );

      expect(pageCubit.state.taskList.length, 1);
    });

    blocTest<TodoListPageCubit, TodoListPageState>(
      'emits initial and update when initial page',
      build: () {
        final TodoListModel todoListModel = TodoListModel(
          nextPage: 1,
          totalPage: 1,
          uiModel: [
            TodoListUIModel(
              title: "Today",
              taskList: [
                MyTask(
                  id: "id",
                  title: "title",
                  description: "description",
                )
              ],
            )
          ],
        );

        when(
          mockUseCase.getTodoList(
            request: anyNamed("request"),
            allTask: anyNamed("allTask"),
          ),
        ).thenAnswer((_) async => todoListModel);

        return TodoListPageCubit(getTodoListUseCase: mockUseCase);
      },
      act: (bloc) => bloc.initial(status: TodoListStatus.todo.value),
      expect: () => <TodoListPageState>[
        const TodoListPageState(
            taskList: [],
            eventState: TodoListPageEventState.initial,
            actionState: TodoListPageActionState.none
        ),
        TodoListPageState(
            taskList: [
              TodoListUIModel(
                title: "Today",
                taskList: [
                  MyTask(
                    id: "id",
                    title: "title",
                    description: "description",
                  )
                ],
              )
            ],
            eventState: TodoListPageEventState.update,
            actionState: TodoListPageActionState.none
        ),
      ],
    );
  });

  tearDown(() => pageCubit.close());
}
