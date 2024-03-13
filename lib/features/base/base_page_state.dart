import "package:equatable/equatable.dart";

class BasePageState extends Equatable {
  final BasePageEventState? eventState;

  const BasePageState({
    this.eventState = BasePageEventState.none,
  });

  @override
  List<Object?> get props => [
        eventState,
      ];

  BasePageState copyWith({
    BasePageEventState? eventState,
  }) {
    return BasePageState(
      eventState: eventState ?? this.eventState,
    );
  }
}

enum BasePageEventState { timeout, none }
