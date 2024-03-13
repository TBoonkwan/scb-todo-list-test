
import 'package:scb_test/features/passcode/input_passcode_screen.dart';
import 'package:scb_test/features/todo/presentation/todo_list_screen.dart';

class InputPasscodeRoute {
  static String inputPasscodeScreen = '/InputPasscodeScreen';

  static final screens = {
    inputPasscodeScreen : (context) =>  const InputPasscodeScreen(),
  };
}
