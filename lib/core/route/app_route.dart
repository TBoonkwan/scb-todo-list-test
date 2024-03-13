import 'package:flutter/cupertino.dart';
import 'package:scb_test/features/passcode/config/input_passcode_route.dart';
import 'package:scb_test/features/todo/config/todo_list_route.dart';

class AppRoute {
  final Map<String, WidgetBuilder> _screens = {};

  AppRoute() {
    _screens.addAll(TodoListRoute.screens);
    _screens.addAll(InputPasscodeRoute.screens);
  }

  get screens => _screens;
}
