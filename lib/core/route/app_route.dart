import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:scb_test/features/todo/config/todo_list_route.dart';

class AppRoute {
  final  Map<String, WidgetBuilder> _screens = {};

  AppRoute() {
    _screens.addAll(TodoListRoute.screens);
  }

  get screens => _screens;
}
