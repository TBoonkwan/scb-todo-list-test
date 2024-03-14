import 'package:flutter/material.dart';
import 'package:scb_test/features/todo/domain/entity/todo_list_ui_model.dart';

class TodoListTaskItem extends StatelessWidget {
  final MyTask item;
  final Function onDeleteTaskClickListener;

  const TodoListTaskItem({
    super.key,
    required this.item,
    required this.onDeleteTaskClickListener,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: () => onDeleteTaskClickListener.call(),
      leading: const Icon(
        Icons.today_outlined,
      ),
      title: Text(
        item.title.toString(),
        style: Theme.of(context).textTheme.titleMedium,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: item.description.isEmpty == true
          ? null
          : Text(
              item.description.toString(),
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.black45),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
    );
  }
}
