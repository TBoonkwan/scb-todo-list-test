import 'package:dio/dio.dart';
import 'package:scb_test/core/configuration/app_config.dart';
import 'package:scb_test/core/module/app_module.dart';
import 'package:scb_test/di/app_module.dart';
import 'package:scb_test/features/todo/data/repository/todo_repository.dart';
import 'package:scb_test/features/todo/data/source/mock/mock_todo_list_data_source.dart';
import 'package:scb_test/features/todo/data/source/remote/remote_todo_list_data_source.dart';
import 'package:scb_test/features/todo/data/source/todo_list_data_source.dart';
import 'package:scb_test/features/todo/domain/mapper/todo_list_mapper.dart';
import 'package:scb_test/features/todo/domain/repository/todo_repository.dart';
import 'package:scb_test/features/todo/domain/usecase/get_todo_list_usecase.dart';

class TodoListModule extends BaseModule {
  @override
  void provideModule() {
    moduleProvider.registerFactory<TodoListDataSource>(
      instanceName: ConfigConstants.mockEnv,
      () => MockTodoListDataSource(),
    );

    moduleProvider.registerFactory<TodoListDataSource>(
      instanceName: ConfigConstants.prodEnv,
      () => RemoteTodoListDataSource(dio: moduleProvider.get<Dio>()),
    );

    moduleProvider.registerFactory<ITodoListRepository>(
      () => TodoListRepository(
          dataSource: moduleProvider.get<TodoListDataSource>(
              instanceName: AppConfig.getEnvironmentInstanceName())),
    );

    moduleProvider.registerFactory(
      () => TodoListMapper(),
    );

    moduleProvider.registerFactory<IGetTodoListUseCase>(
      () => GetTodoListUseCase(
        todoListRepository: moduleProvider.get<ITodoListRepository>(),
        mapper: moduleProvider.get(),
      ),
    );
  }
}
