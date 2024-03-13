import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scb_test/features/base/base_page_cubit.dart';
import 'package:scb_test/features/todo/config/todo_list_provider.dart';

class AppProvider {
  final List<BlocProvider> _provider = [];

  AppProvider() {
    _provider.add(BlocProvider<BasePageCubit>(
      create: (BuildContext context) => BasePageCubit(),
    ));
    _provider.addAll(TodoListProvider.providers);
  }

  get provider => _provider;
}
