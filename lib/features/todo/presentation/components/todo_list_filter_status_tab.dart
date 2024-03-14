import 'package:flutter/material.dart';

class TodoListFilterStatusTab extends StatelessWidget {
  final List<String> tabList;
  final Function(String) tabSelected;

  const TodoListFilterStatusTab({
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
