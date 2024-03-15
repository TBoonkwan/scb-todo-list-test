import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scb_test/features/passcode/presentation/change_passcode/change_password_page_cubit.dart';
import 'package:scb_test/features/passcode/presentation/input_passcode/input_passcode_page_cubit.dart';

class PasscodeProvider {
  static final List<BlocProvider> providers = [
    BlocProvider<InputPasscodePageCubit>(
      create: (BuildContext context) => InputPasscodePageCubit(),
    ),
    BlocProvider<ChangePasswordPageCubit>(
      create: (BuildContext context) => ChangePasswordPageCubit(),
    ),
  ];
}
