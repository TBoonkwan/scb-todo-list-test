import 'package:get_storage/get_storage.dart';
import 'package:scb_test/features/base/data/base_constants.dart';
import 'package:scb_test/features/passcode/config/input_passcode_route.dart';
import 'package:scb_test/features/todo/config/todo_list_route.dart';

mixin AppStarterDelegate {
  String checkIsShouldShowPin() {
    GetStorage storage = GetStorage();

    final String? lastActive = storage.read(BaseConstants.latestActive);

    if (lastActive == null) {
      return TodoListRoute.todoListScreen;
    }

    final DateTime now = DateTime.now();
    final Duration differentTime = DateTime.parse(lastActive).difference(now);

    if (differentTime.inSeconds <= -10) {
      return InputPasscodeRoute.inputPasscodeScreen;
    } else {
      return TodoListRoute.todoListScreen;
    }
  }
}
