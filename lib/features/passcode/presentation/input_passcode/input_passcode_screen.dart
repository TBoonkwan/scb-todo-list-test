import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scb_test/features/passcode/presentation/components/scb_passcode_screen.dart';
import 'package:scb_test/features/passcode/presentation/input_passcode/input_passcode_page_cubit.dart';
import 'package:scb_test/features/passcode/presentation/input_passcode/input_passcode_page_state.dart';
import 'package:scb_test/features/todo/config/todo_list_route.dart';

class InputPasscodeScreenConfig {
  String title;
  bool canBackOrClose;

  InputPasscodeScreenConfig({
    required this.title,
    this.canBackOrClose = true,
  });
}

class InputPasscodeScreen extends StatefulWidget {
  const InputPasscodeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<InputPasscodeScreen> createState() => _InputPasscodeScreenState();
}

class _InputPasscodeScreenState extends State<InputPasscodeScreen> {
  InputPasscodeScreenConfig? _inputScreenConfig;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<InputPasscodePageCubit>().init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dynamic arguments = ModalRoute.of(context)?.settings.arguments;

    if (arguments != null && arguments is InputPasscodeScreenConfig) {
      _inputScreenConfig = arguments;
    } else {
      _inputScreenConfig =
          InputPasscodeScreenConfig(title: 'Please enter your PIN');
    }

    return PopScope(
      canPop: _inputScreenConfig?.canBackOrClose == true,
      child: BlocListener<InputPasscodePageCubit, InputPasscodePageState>(
        listener: (context, state) async {
          switch (state.actionState) {
            case InputPasscodePageActionState.inputSuccess:
              context.read<InputPasscodePageCubit>().reset();

              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                Navigator.of(context).popAndPushNamed(
                  TodoListRoute.todoListScreen,
                );
              }

              break;
            default:
          }
        },
        child: Scaffold(
          body: Stack(
            children: [
              BlocBuilder<InputPasscodePageCubit, InputPasscodePageState>(
                builder: (BuildContext context, InputPasscodePageState state) {
                  if (state.eventState == InputPasscodePageEventState.none) {
                    return const SizedBox();
                  }
                  return SCBPasscodeScreen(
                    title: _inputScreenConfig?.title.toString() ?? "",
                    password: state.passcode.toString(),
                    unlockAccount: () {
                      context.read<InputPasscodePageCubit>().inputPasscodeSuccess();
                    },
                  );
                },
              ),
              Builder(
                builder: (BuildContext context) {
                  if (_inputScreenConfig?.canBackOrClose == true) {
                    return Positioned(
                      top: 56,
                      right: 24,
                      child: PasscodeCloseButton(
                        onPressed: () {
                          if (Navigator.canPop(context)) {
                            Navigator.pop(context);
                          } else {
                            exit(0);
                          }
                        },
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PasscodeCloseButton extends StatelessWidget {
  final Function onPressed;

  const PasscodeCloseButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return IconButton(
        onPressed: () => onPressed.call(),
        icon: const Icon(
          Icons.close,
          color: Colors.white,
        ),
      );
    });
  }
}
