import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scb_test/features/base/base_page_cubit.dart';
import 'package:scb_test/features/passcode/config/passcode_provider.dart';
import 'package:scb_test/features/todo/config/todo_list_provider.dart';

class AppProvider {
  final List<BlocProvider> _provider = [];

  AppProvider() {
    _provider
      ..add(BlocProvider<BasePageCubit>(
        create: (BuildContext context) => BasePageCubit(),
      ))
      ..addAll(TodoListProvider.providers)
      ..addAll(PasscodeProvider.providers);
  }

  get provider => _provider;
}
