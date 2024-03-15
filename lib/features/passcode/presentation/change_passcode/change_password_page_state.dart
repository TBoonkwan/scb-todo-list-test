import "package:equatable/equatable.dart";

class ChangePasswordPageState extends Equatable {
  final String? newPasscode;
  final String? confirmPasscode;
  final InputPasscodePageActionState? actionState;

  const ChangePasswordPageState({
    this.newPasscode = "",
    this.confirmPasscode = "",
    this.actionState = InputPasscodePageActionState.none,
  });

  @override
  List<Object?> get props => [
        newPasscode,
        confirmPasscode,
        actionState,
      ];

  ChangePasswordPageState copyWith({
    String? newPasscode,
    String? confirmPasscode,
    InputPasscodePageActionState? actionState,
  }) {
    return ChangePasswordPageState(
      newPasscode: newPasscode ?? this.newPasscode,
      confirmPasscode: confirmPasscode ?? this.confirmPasscode,
      actionState: actionState ?? this.actionState,
    );
  }
}

enum InputPasscodePageActionState {
  create,
  success,
  none,
}
