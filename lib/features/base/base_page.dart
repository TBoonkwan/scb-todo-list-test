import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scb_test/features/base/base_page_cubit.dart';
import 'package:scb_test/features/base/base_page_state.dart';
import 'package:scb_test/features/passcode/config/passcode_route.dart';
import 'package:scb_test/features/passcode/presentation/input_passcode/input_passcode_screen.dart';

abstract class BasePage<T extends StatefulWidget> extends State<T> {
  BasePageCubit? basePageCubit;

  AppLifecycleListener? _listener;

  Widget child(BuildContext context);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      basePageCubit = context.read<BasePageCubit>()..startTimer();
    });

    _listener = AppLifecycleListener(onResume: () {
      basePageCubit
        ?..reset()
        ..startTimer();
    }, onStateChange: (state) {
      if (state == AppLifecycleState.inactive &&
          basePageCubit?.isTimeout() == false) {
        basePageCubit
          ?..reset()
          ..updateLatestActive();
      }
    });
  }

  @override
  void dispose() {
    _listener?.dispose();
    basePageCubit?.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        basePageCubit
          ?..reset()
          ..startTimer();
      },
      child: BlocListener<BasePageCubit, BasePageState>(
        listenWhen: (prev, current) => current.eventState != prev.eventState,
        listener: (context, state) async {
          switch (state.eventState) {
            case BasePageEventState.timeout:
              await Navigator.of(context).pushNamed(
                PasscodeRoute.inputPasscodeScreen,
                arguments: InputPasscodeScreenConfig(
                  canBackOrClose: false,
                  title: 'Please enter your PIN',
                ),
              );
              basePageCubit
                ?..reset()
                ..startTimer();
              break;
            default:
          }
        },
        child: child(
          context,
        ),
      ),
    );
  }
}
