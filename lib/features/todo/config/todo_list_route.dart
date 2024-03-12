import 'package:get/get.dart';
import 'package:scb_test/features/todo/presentation/todo_list_screen.dart';

class TodoListRoute {
  static String todoListScreen = '/TodoListScreen';

  static final screens = {
    todoListScreen : (context) =>  const TodoListScreen(),
  };
}
