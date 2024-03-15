import "package:flutter_bloc/flutter_bloc.dart";
import "package:get_storage/get_storage.dart";
import "package:scb_test/core/constants/app_constants.dart";
import "package:scb_test/features/passcode/presentation/input_passcode/input_passcode_page_state.dart";

class InputPasscodePageCubit extends Cubit<InputPasscodePageState> {
  InputPasscodePageCubit() : super(const InputPasscodePageState()) {

  }

  void init(){
    GetStorage storage = GetStorage();
    emit(
      state.copyWith(
        passcode: storage.read(AppConstants.passcode) ?? "123456",
      ),
    );
  }

  void inputPasscodeSuccess() {
    emit(
        state.copyWith(actionState: InputPasscodePageActionState.inputSuccess));
  }

  void reset() {
    emit(
        state.copyWith(actionState: InputPasscodePageActionState.none));
  }
}
