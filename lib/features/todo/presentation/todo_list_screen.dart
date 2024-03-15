import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scb_test/features/base/base_page.dart';
import 'package:scb_test/features/passcode/config/passcode_route.dart';
import 'package:scb_test/features/passcode/data/passcode_constants.dart';
import 'package:scb_test/features/passcode/presentation/change_passcode/change_passcode_screen.dart';
import 'package:scb_test/features/passcode/presentation/input_passcode/input_passcode_screen.dart';
import 'package:scb_test/features/todo/data/constants/todo_list_constants.dart';
import 'package:scb_test/features/todo/domain/entity/todo_list_ui_model.dart';
import 'package:scb_test/features/todo/presentation/components/todo_list_filter_status_tab.dart';
import 'package:scb_test/features/todo/presentation/components/todo_list_task_header.dart';
import 'package:scb_test/features/todo/presentation/components/todo_list_task_list_section.dart';
import 'package:scb_test/features/todo/presentation/todo_list_page_cubit.dart';
import 'package:scb_test/features/todo/presentation/todo_list_page_state.dart';
import 'package:scb_test/shared/loading/loading_indicator.dart';

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
          .initial(status: TodoListStatus.todo.value);
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

    return BlocListener<TodoListPageCubit, TodoListPageState>(
      listenWhen: (prev, current) => current.actionState != prev.actionState,
      listener: (context, state) async {
        switch (state.actionState) {
          case TodoListPageActionState.verifyPasscode:
            await Navigator.of(context).pushNamed(
              PasscodeRoute.inputPasscodeScreen,
              arguments: InputPasscodeScreenConfig(
                title: "Please enter your current PIN",
                canBackOrClose: true,
              ),
            );

            cubit.navigateToChangePasscode();
            break;
          case TodoListPageActionState.changePasscode:
            await Navigator.of(context).pushNamed(
              PasscodeRoute.changePasscodeScreen,
              arguments: ChangePasscodeArguments(
                password: "xxxxxx",
                passcodeType: PasscodeType.createPasscode,
              ),
            );
            break;
          default:
        }
      },
      child: Scaffold(
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
                actions: [
                  IconButton(
                    onPressed: () async {
                      cubit.navigateToVerifyPasscode();
                    },
                    icon: const Icon(
                      Icons.account_circle_outlined,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                ],
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
                      context.read<TodoListPageCubit>().initial(status: status);
                    },
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  BlocConsumer<TodoListPageCubit, TodoListPageState>(
                    listenWhen: (prev, current) =>
                        current.eventState != prev.eventState,
                    listener: (context, state) async {},
                    builder: (BuildContext context, TodoListPageState state) {
                      if (state.eventState == TodoListPageEventState.initial) {
                        return LoadingIndicator(
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
                      }

                      if (state.eventState == TodoListPageEventState.update) {
                        return TodoListContent(
                          taskList: state.taskList,
                        );
                      }

                      return const SizedBox();
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
            if (state.actionState == TodoListPageActionState.loadMore) {
              return const LoadingIndicator(size: Size(80, 80));
            }

            return const SizedBox(
              height: 0,
            );
          },
        ),
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
