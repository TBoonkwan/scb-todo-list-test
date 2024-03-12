import 'package:scb_test/core/module/app_module.dart';
import 'package:scb_test/di/app_module.dart';
import 'package:scb_test/features/todo/data/repository/todo_repository.dart';
import 'package:scb_test/features/todo/data/source/mock/mock_todo_list_data_source.dart';
import 'package:scb_test/features/todo/data/source/remote/remote_todo_list_data_source.dart';
import 'package:scb_test/features/todo/data/source/todo_list_data_source.dart';
import 'package:scb_test/features/todo/domain/repository/todo_repository.dart';

class TodoListModule extends BaseModule {
  @override
  void provideModule() {
    moduleProvider.registerFactory<TodoListDataSource>(
      instanceName: "mock",
      () => MockTodoListDataSource(),
    );

    moduleProvider.registerFactory<TodoListDataSource>(
      instanceName: "prod",
      () => RemoteTodoListDataSource(),
    );

    moduleProvider.registerFactory<ITodoListRepository>(
      () => TodoListRepository(
        dataSource: moduleProvider.get<TodoListDataSource>(instanceName: "mock")
      ),
    );
  }
}
