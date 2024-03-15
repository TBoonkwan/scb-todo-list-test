import "package:flutter_bloc/flutter_bloc.dart";
import "package:get_storage/get_storage.dart";
import "package:scb_test/core/constants/app_constants.dart";
import "package:scb_test/features/passcode/data/passcode_constants.dart";
import "package:scb_test/features/passcode/presentation/change_passcode/change_password_page_state.dart";

class ChangePasswordPageCubit extends Cubit<ChangePasswordPageState> {
  ChangePasswordPageCubit() : super(const ChangePasswordPageState());
  PasscodeType passcodeType = PasscodeType.createPasscode;

  void setNewPassword({
    required String password,
    required PasscodeType passcodeType,
  }) {
    this.passcodeType = passcodeType;

    emit(
      state.copyWith(
        newPasscode: password,
      ),
    );
  }

  void inputPasscodeSuccess({
    required String password,
  }) {
    emit(
      state.copyWith(
          newPasscode: password,
          actionState: InputPasscodePageActionState.create),
    );
  }

  void changeNewPasscode({
    required String passcode,
  }) {
    emit(
      state.copyWith(
        confirmPasscode: passcode,
      ),
    );
  }

  void createPasscodeSuccess() {
    GetStorage storage = GetStorage();
    storage.write(AppConstants.passcode, state.newPasscode.toString());
    emit(
      state.copyWith(
        newPasscode: state.newPasscode,
        actionState: InputPasscodePageActionState.success,
      ),
    );
  }

  void reset() {
    emit(ChangePasswordPageState());
  }
}
