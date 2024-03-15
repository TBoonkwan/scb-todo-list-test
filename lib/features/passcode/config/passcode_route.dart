import 'package:scb_test/features/passcode/presentation/change_passcode/change_passcode_screen.dart';
import 'package:scb_test/features/passcode/presentation/input_passcode/input_passcode_screen.dart';

class PasscodeRoute {
  static String inputPasscodeScreen = '/InputPasscodeScreen';
  static String changePasscodeScreen = '/ChangePasscodeScreen';

  static final screens = {
    inputPasscodeScreen: (context) => const InputPasscodeScreen(),
    changePasscodeScreen: (context) => const ChangePasscodeScreen(),
  };
}
