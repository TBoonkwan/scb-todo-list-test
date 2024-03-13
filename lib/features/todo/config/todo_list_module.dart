import 'package:dio/dio.dart';
import 'package:scb_test/core/configuration/app_config.dart';
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
      instanceName: AppConstants.mockEnv,
      () => MockTodoListDataSource(),
    );

    moduleProvider.registerFactory<TodoListDataSource>(
      instanceName: AppConstants.prodEnv,
      () => RemoteTodoListDataSource(dio: moduleProvider.get<Dio>()),
    );

    moduleProvider.registerFactory<ITodoListRepository>(
      () => TodoListRepository(
          dataSource: moduleProvider.get<TodoListDataSource>(
              instanceName: AppConfig.getEnvironmentInstanceName())),
    );
  }
}
