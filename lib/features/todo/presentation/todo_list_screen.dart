import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:scb_test/features/base/base_page.dart';
import 'package:scb_test/features/todo/data/constants/todo_list_constants.dart';
import 'package:scb_test/features/todo/domain/entity/todo_list_ui_model.dart';
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
  List<String> tabList = [
    "Todo",
    "Doing",
    "Done",
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<TodoListPageCubit>()
          .getTodoList(status: TodoListStatus.todo.value);
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
                tabSelected: (status) {
                  context.read<TodoListPageCubit>().getTodoList(status: status);
                },
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
  final Function(String) tabSelected;

  const TodoFilterStatusTab({
    super.key,
    required this.tabList,
    required this.tabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabList.length,
      animationDuration: const Duration(milliseconds: 500),
      child: TabBar(
        onTap: (index) {
          tabSelected.call(tabList[index]);
        },
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white38,
        indicatorColor: Colors.transparent,
        tabs: tabList.map((e) => Tab(text: e)).toList(),
      ),
    );
  }
}

class TodoListWidget extends StatelessWidget {
  final List<TodoListUIModel> taskList;

  const TodoListWidget({
    super.key,
    required this.taskList,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      primary: false,
      padding: const EdgeInsets.symmetric(
        vertical: 16,
      ),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        final TodoListUIModel uiModel = taskList[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TodoListHeaderSection(uiModel: uiModel),
            Builder(builder: (context) {
              if (taskList.isEmpty == true) {
                return const Center(
                  child: Text("No task"),
                );
              }
              return TodoListChildSection(
                uiModel: uiModel,
              );
            })
          ],
        );
      },
      itemCount: taskList.length,
    );
  }
}

class TodoListHeaderSection extends StatelessWidget {
  final TodoListUIModel uiModel;

  const TodoListHeaderSection({
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

class TodoListChildSection extends StatelessWidget {
  final TodoListUIModel uiModel;

  const TodoListChildSection({
    super.key,
    required this.uiModel,
  });

  Future showConfirmationToDeleteTaskDialog({
    required BuildContext context,
    required MyTask item,
  }) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return ConfirmationToDeleteDialog(
            onDialogClickListener: (deleted) {
              if (deleted) {
                // context.read<TodoListPageCubit>().deleteTask(task: item);
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
        height: 1,
      ),
      itemCount: uiModel.taskList.length,
    );
  }
}

class ItemTodoListWidget extends StatelessWidget {
  final MyTask item;
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
