import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scb_test/di/app_module.dart';
import 'package:scb_test/features/todo/domain/usecase/get_todo_list_usecase.dart';
import 'package:scb_test/features/todo/presentation/todo_list_page_cubit.dart';

class TodoListProvider {
  static final providers = [
    BlocProvider<TodoListPageCubit>(
      create: (BuildContext context) => TodoListPageCubit(
        getTodoListUseCase: moduleProvider.get<IGetTodoListUseCase>(),
      ),
    ),
  ];
}
