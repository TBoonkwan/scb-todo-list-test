import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:scb_test/features/base/base_page.dart';
import 'package:scb_test/features/todo/data/model/task.dart';
import 'package:scb_test/features/todo/presentation/todo_list_page_cubit.dart';
import 'package:scb_test/features/todo/presentation/todo_list_page_state.dart';
import 'package:scb_test/shared/dialog/confirmation_to_delete_dialog.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({
    super.key,
  });

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends BasePage<TodoListScreen> {
  String selectedTab = "Todo";

  List<String> tabList = [
    "Todo",
    "Doing",
    "Done",
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TodoListPageCubit>().getTodoList();
    });
  }

  @override
  void dispose() {
    context.read<TodoListPageCubit>().reset();
    super.dispose();
  }

  @override
  Widget child(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(36),
              bottomRight: Radius.circular(36),
            )),
            toolbarHeight: 56,
            pinned: true,
            bottom: PreferredSize(
              preferredSize: const Size(double.infinity, 56),
              child: TodoFilterStatusTab(
                tabList: tabList,
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            BlocBuilder<TodoListPageCubit, TodoListPageState>(
              builder: (
                BuildContext context,
                TodoListPageState state,
              ) {
                if (state.eventState == TodoListPageEventState.loading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return TodoListWidget(
                  taskList: state.taskList,
                );
              },
            ),
          ]))
        ],
      ),
    );
  }
}

class TodoFilterStatusTab extends StatelessWidget {
  final List<String> tabList;

  const TodoFilterStatusTab({
    super.key,
    required this.tabList,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabList.length,
      animationDuration: const Duration(milliseconds: 500),
      child: TabBar(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white38,
        indicatorColor: Colors.transparent,
        tabs: tabList
            .map(
              (e) => Tab(
                text: e,
              ),
            )
            .toList(),
      ),
    );
  }
}

class TodoListWidget extends StatelessWidget {
  final List<Task> taskList;

  const TodoListWidget({
    super.key,
    required this.taskList,
  });

  Future showConfirmationToDeleteTaskDialog({
    required BuildContext context,
    required Task item,
  }) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return ConfirmationToDeleteDialog(
            onDialogClickListener: (deleted) {
              if (deleted) {
                context.read<TodoListPageCubit>().deleteTask(task: item);
              }
              Navigator.of(context).pop();
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    if (taskList.isEmpty == true) {
      return const Center(
        child: Text("No task"),
      );
    }

    return ListView.separated(
      primary: false,
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      key: const Key("ListTodoWidget"),
      itemBuilder: (BuildContext context, int index) {
        final SwipeActionController controller = SwipeActionController();
        final Task task = taskList[index];
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
          child: ItemTodoListWidget(
            key: Key(index.toString()),
            item: task,
            onDeleteTaskClickListener: () {
              showConfirmationToDeleteTaskDialog(
                context: context,
                item: task,
              );
            },
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(
        height: 0,
      ),
      itemCount: taskList.length,
    );
  }
}

class ItemTodoListWidget extends StatelessWidget {
  final Task item;
  final Function onDeleteTaskClickListener;

  const ItemTodoListWidget({
    super.key,
    required this.item,
    required this.onDeleteTaskClickListener,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: () => onDeleteTaskClickListener.call(),
      title: Text(
        item.title.toString(),
      ),
      subtitle: item.description?.isEmpty == true
          ? null
          : Text(item.description.toString()),
    );
  }
}
