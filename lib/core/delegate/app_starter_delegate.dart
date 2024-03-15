import 'package:get_storage/get_storage.dart';
import 'package:scb_test/core/constants/app_constants.dart';
import 'package:scb_test/features/passcode/config/passcode_route.dart';
import 'package:scb_test/features/todo/config/todo_list_route.dart';

mixin AppStarterDelegate {
  String checkIsShouldShowPin() {
    GetStorage storage = GetStorage();

    final String? lastActive = storage.read(AppConstants.latestActive);

    if (lastActive == null) {
      storage.write(AppConstants.passcode, "123456");
      return TodoListRoute.todoListScreen;
    }

    final DateTime now = DateTime.now();
    final Duration differentTime = DateTime.parse(lastActive).difference(now);

    if (differentTime.inSeconds <= -10) {
      return PasscodeRoute.inputPasscodeScreen;
    } else {
      return TodoListRoute.todoListScreen;
    }
  }
}
