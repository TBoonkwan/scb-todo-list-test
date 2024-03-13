import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scb_test/features/base/base_page_cubit.dart';
import 'package:scb_test/features/base/base_page_state.dart';
import 'package:scb_test/features/passcode/config/input_passcode_route.dart';
import 'package:scb_test/features/passcode/input_passcode_screen.dart';

abstract class BasePage<T extends StatefulWidget> extends State<T> {
  BasePageCubit? basePageCubit;

  Widget child(BuildContext context);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      basePageCubit = context.read<BasePageCubit>()..startTimer();
    });
  }

  @override
  void dispose() {
    basePageCubit?.updateLatestActive();
    basePageCubit?.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => basePageCubit?.reset(),
      child: BlocListener<BasePageCubit, BasePageState>(
        listenWhen: (prev, current) => current.eventState != prev.eventState,
        listener: (context, state) async {
          switch (state.eventState) {
            case BasePageEventState.timeout:
              await Navigator.of(context).pushNamed(
                InputPasscodeRoute.inputPasscodeScreen,
                arguments: InputScreenConfig(
                  shouldShowCloseIcon: false,
                ),
              );
              basePageCubit?.reset();
              basePageCubit?.startTimer();
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
