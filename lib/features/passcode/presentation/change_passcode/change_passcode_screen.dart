import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scb_test/features/passcode/config/passcode_route.dart';
import 'package:scb_test/features/passcode/data/passcode_constants.dart';
import 'package:scb_test/features/passcode/presentation/change_passcode/change_password_page_cubit.dart';
import 'package:scb_test/features/passcode/presentation/change_passcode/change_password_page_state.dart';
import 'package:scb_test/features/passcode/presentation/components/scb_passcode_screen.dart';
import 'package:scb_test/features/passcode/presentation/input_passcode/input_passcode_screen.dart';

class ChangePasscodeArguments {
  final String password;
  final PasscodeType passcodeType;

  ChangePasscodeArguments({
    required this.password,
    required this.passcodeType,
  });
}

class ChangePasscodeScreen extends StatefulWidget {
  const ChangePasscodeScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasscodeScreen> createState() => _ChangePasscodeScreenState();
}

class _ChangePasscodeScreenState extends State<ChangePasscodeScreen> {
  ChangePasswordPageCubit? pageCubit;

  @override
  void initState() {
    super.initState();
    pageCubit = context.read<ChangePasswordPageCubit>();
  }

  @override
  Widget build(BuildContext context) {
    final dynamic arguments = ModalRoute.of(context)?.settings.arguments;

    if (arguments != null && arguments is ChangePasscodeArguments) {
      pageCubit?.setNewPassword(
        passcodeType: arguments.passcodeType,
        password: arguments.password,
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          BlocListener<ChangePasswordPageCubit, ChangePasswordPageState>(
            listener: (context, state) async {
              switch (state.actionState) {
                case InputPasscodePageActionState.create:
                  Navigator.of(context).pushNamed(
                    PasscodeRoute.changePasscodeScreen,
                    arguments: ChangePasscodeArguments(
                      password: pageCubit?.state.newPasscode.toString() ?? "",
                      passcodeType: PasscodeType.confirmPasscode,
                    ),
                  );
                  break;
                case InputPasscodePageActionState.success:
                  pageCubit?.reset();
                  Navigator.of(context).pop();
                  break;
                default:
              }
            },
            child: Builder(builder: (context) {
              String title = "";
              if (pageCubit?.passcodeType == PasscodeType.createPasscode) {
                title = 'Please create your new PIN';
              } else {
                title = 'Please confirm your new PIN';
              }
              return SCBPasscodeScreen(
                title: title,
                password: pageCubit?.state.newPasscode.toString() ?? "",
                textInputChanged: (password) {
                  if (pageCubit?.passcodeType == PasscodeType.createPasscode) {
                    pageCubit?.inputPasscodeSuccess(password: password);
                  }
                },
                unlockAccount: () {
                  pageCubit?.createPasscodeSuccess();
                },
              );
            }),
          ),
          Positioned(
            top: 56,
            right: 24,
            child: PasscodeCloseButton(
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
