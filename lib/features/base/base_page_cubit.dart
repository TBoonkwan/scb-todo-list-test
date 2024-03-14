import "dart:async";

import "package:flutter_bloc/flutter_bloc.dart";
import "package:get_storage/get_storage.dart";
import "package:scb_test/core/constants/app_constants.dart";
import "package:scb_test/features/base/base_page_state.dart";

class BasePageCubit extends Cubit<BasePageState> {
  final storage = GetStorage();
  final Duration maxTimeout = const Duration(seconds: 10);

  late Timer? timer;

  BasePageCubit() : super(const BasePageState());

  void startTimer() {
    timer = Timer.periodic(
      maxTimeout,
      (Timer timer) {
        updateLatestActive();
        emit(
          state.copyWith(eventState: BasePageEventState.timeout),
        );
        timer.cancel();
      },
    );
  }

  void reset() {
    timer?.cancel();

    emit(
      state.copyWith(eventState: BasePageEventState.none),
    );
  }

  void updateLatestActive() {
    storage.write(AppConstants.latestActive, DateTime.now().toIso8601String());
  }

  bool isTimeout() => state.eventState == BasePageEventState.timeout;
}
