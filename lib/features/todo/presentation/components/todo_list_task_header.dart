import 'package:flutter/material.dart';
import 'package:scb_test/features/todo/domain/entity/todo_list_ui_model.dart';

class TodoListTaskHeader extends StatelessWidget {
  final TodoListUIModel uiModel;

  const TodoListTaskHeader({
    super.key,
    required this.uiModel,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      isThreeLine: false,
      title: Text(
        uiModel.title,
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}
