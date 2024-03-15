import "package:equatable/equatable.dart";

class InputPasscodePageState extends Equatable {
  final String? passcode;
  final InputPasscodePageActionState? actionState;

  const InputPasscodePageState({
    this.passcode = "",
    this.actionState = InputPasscodePageActionState.none,
  });

  @override
  List<Object?> get props => [
        passcode,
        actionState,
      ];

  InputPasscodePageState copyWith({
    String? passcode,
    InputPasscodePageActionState? actionState,
  }) {
    return InputPasscodePageState(
      passcode: passcode ?? this.passcode,
      actionState: actionState ?? this.actionState,
    );
  }
}

enum InputPasscodePageActionState {
  inputSuccess,
  none,
}
