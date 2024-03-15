import "package:equatable/equatable.dart";

class InputPasscodePageState extends Equatable {
  final InputPasscodePageActionState? actionState;
  final InputPasscodePageEventState? eventState;

  final String? passcode;

  const InputPasscodePageState({
    this.eventState = InputPasscodePageEventState.none,
    this.actionState = InputPasscodePageActionState.none,
    this.passcode = "xxxxxx",
  });

  @override
  List<Object?> get props => [
        eventState,
        actionState,
        passcode,
      ];

  InputPasscodePageState copyWith({
    InputPasscodePageEventState? eventState,
    InputPasscodePageActionState? actionState,
    String? passcode,
  }) {
    return InputPasscodePageState(
      eventState: eventState ?? this.eventState,
      actionState: actionState ?? this.actionState,
      passcode: passcode ?? this.passcode,
    );
  }
}

enum InputPasscodePageEventState {
  initial,
  none,
}

enum InputPasscodePageActionState {
  inputSuccess,
  none,
}
