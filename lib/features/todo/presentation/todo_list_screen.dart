import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scb_test/features/base/base_page.dart';
import 'package:scb_test/features/todo/data/constants/todo_list_constants.dart';
import 'package:scb_test/features/todo/domain/entity/todo_list_ui_model.dart';
import 'package:scb_test/features/todo/presentation/components/todo_list_filter_status_tab.dart';
import 'package:scb_test/features/todo/presentation/components/todo_list_task_header.dart';
import 'package:scb_test/features/todo/presentation/components/todo_list_task_list_section.dart';
import 'package:scb_test/features/todo/presentation/todo_list_page_cubit.dart';
import 'package:scb_test/features/todo/presentation/todo_list_page_state.dart';

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

    final TodoListPageCubit cubit = context.read<TodoListPageCubit>();

    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification.metrics.pixels ==
              scrollNotification.metrics.maxScrollExtent) {
            cubit.loadMoreItem();
          }
          return true;
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36),
                ),
              ),
              toolbarHeight: 56,
              pinned: true,
              bottom: PreferredSize(
                preferredSize: const Size(double.infinity, 56),
                child: TodoListFilterStatusTab(
                  tabList: tabList,
                  tabSelected: (status) {
                    context
                        .read<TodoListPageCubit>()
                        .getTodoList(status: status);
                  },
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                BlocBuilder<TodoListPageCubit, TodoListPageState>(
                  builder: (BuildContext context, TodoListPageState state) {
                    if (state.eventState == TodoListPageEventState.initial) {
                      return Loading(
                        size: Size(
                          MediaQuery.sizeOf(context).width,
                          MediaQuery.sizeOf(context).height * 0.7,
                        ),
                      );
                    }

                    if (state.eventState == TodoListPageEventState.noTask) {
                      return SizedBox(
                        width: MediaQuery.sizeOf(context).width,
                        height: MediaQuery.sizeOf(context).height * 0.7,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Center(
                            child: Text("No task"),
                          ),
                        ),
                      );
                    } else {
                      return TodoListContent(
                        taskList: state.taskList,
                      );
                    }
                  },
                ),
              ]),
            )
          ],
        ),
      ),
      bottomNavigationBar: BlocConsumer<TodoListPageCubit, TodoListPageState>(
        listenWhen: (prev, current) => current.eventState != prev.eventState,
        listener: (context, state) async {},
        builder: (context, state) {
          if (state.eventState == TodoListPageEventState.loadMore) {
            return const Loading(size: Size(80, 80));
          }

          return const SizedBox(
            height: 0,
          );
        },
      ),
    );
  }
}

class Loading extends StatelessWidget {
  final Size size;

  const Loading({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class TodoListContent extends StatelessWidget {
  final List<TodoListUIModel> taskList;

  const TodoListContent({
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
        return Builder(builder: (context) {
          if (uiModel.taskList.isEmpty == true) {
            return const SizedBox();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TodoListTaskHeader(uiModel: uiModel),
              TodoListTaskListSection(
                uiModel: uiModel,
              )
            ],
          );
        });
      },
      itemCount: taskList.length,
    );
  }
}
