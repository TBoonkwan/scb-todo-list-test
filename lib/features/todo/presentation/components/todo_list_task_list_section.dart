import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:scb_test/features/todo/domain/entity/todo_list_ui_model.dart';
import 'package:scb_test/features/todo/presentation/components/todo_list_task_item.dart';
import 'package:scb_test/features/todo/presentation/todo_list_page_cubit.dart';
import 'package:scb_test/shared/dialog/confirmation_to_delete_dialog.dart';

class TodoListTaskListSection extends StatelessWidget {
  final TodoListUIModel uiModel;

  const TodoListTaskListSection({
    super.key,
    required this.uiModel,
  });

  Future showConfirmationToDeleteTaskDialog({
    required BuildContext context,
    required TodoListUIModel uiModel,
    required MyTask item,
  }) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return ConfirmationToDeleteDialog(
            onDialogClickListener: (deleted) {
              if (deleted) {
                context
                    .read<TodoListPageCubit>()
                    .deleteTask(uiModel: uiModel, task: item);
              }
              Navigator.of(context).pop();
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      primary: false,
      padding: const EdgeInsets.symmetric(
        vertical: 4,
      ),
      shrinkWrap: true,
      key: const Key("ListTodoWidget"),
      itemBuilder: (BuildContext context, int index) {
        final SwipeActionController controller = SwipeActionController();
        final MyTask task = uiModel.taskList[index];
        return SwipeActionCell(
          controller: controller,
          key: ObjectKey(index.toString()),
          isDraggable: true,
          trailingActions: [
            SwipeAction(
              color: Colors.red,
              onTap: (handler) async {
                await showConfirmationToDeleteTaskDialog(
                  context: context,
                  uiModel: uiModel,
                  item: task,
                );
                controller.closeAllOpenCell();
              },
              content: const SizedBox(
                width: 80,
                height: double.infinity,
                child: Icon(
                  Icons.delete,
                ),
              ),
            ),
          ],
          child: TodoListTaskItem(
            key: Key(index.toString()),
            item: task,
            onDeleteTaskClickListener: () {
              showConfirmationToDeleteTaskDialog(
                context: context,
                uiModel: uiModel,
                item: task,
              );
            },
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(
        height: 1,
      ),
      itemCount: uiModel.taskList.length,
    );
  }
}
