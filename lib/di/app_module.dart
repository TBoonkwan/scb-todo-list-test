import 'package:get_it/get_it.dart';
import 'package:scb_test/core/api/api_manager.dart';
import 'package:scb_test/features/todo/config/todo_list_module.dart';

var moduleProvider = GetIt.instance;

class AppModule {
  Future provideModule() async {
    moduleProvider.registerFactory(() => ApiManager().initial());

    TodoListModule().provideModule();
  }
}
