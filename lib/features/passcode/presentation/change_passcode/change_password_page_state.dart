import "package:equatable/equatable.dart";

class ChangePasswordPageState extends Equatable {
  final String? newPasscode;
  final InputPasscodePageActionState? actionState;
  final InputPasscodePageEventState? eventState;

  const ChangePasswordPageState({
    this.newPasscode = "xxxxxx",
    this.actionState = InputPasscodePageActionState.none,
    this.eventState = InputPasscodePageEventState.none,
  });

  @override
  List<Object?> get props => [
        newPasscode,
        eventState,
        actionState,
      ];

  ChangePasswordPageState copyWith({
    String? newPasscode,
    InputPasscodePageEventState? eventState,
    InputPasscodePageActionState? actionState,
  }) {
    return ChangePasswordPageState(
      newPasscode: newPasscode ?? this.newPasscode,
      eventState: eventState ?? this.eventState,
      actionState: actionState ?? this.actionState,
    );
  }
}

enum InputPasscodePageEventState {
  initial,
  none,
}

enum InputPasscodePageActionState {
  create,
  success,
  none,
}
