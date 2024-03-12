import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scb_test/features/todo/config/todo_list_provider.dart';

class AppProvider {
  final List<BlocProvider> _provider = [];

  AppProvider() {
    _provider.addAll(TodoListProvider.providers);
  }

  get provider => _provider;
}
