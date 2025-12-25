import 'package:flutter/material.dart';
import 'tab/grocery_tab.dart';
import 'tab/search_tab.dart';

class TabDetail extends StatefulWidget {
  final String tabId;
  const TabDetail({super.key, required this.tabId});

  @override
  State<TabDetail> createState() => _TabDetailState();
}

enum GroceryTabType { grocery, search }

class _TabDetailState extends State<TabDetail> {
  GroceryTabType _currentTab = GroceryTabType.grocery;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: _currentTab.index,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Details'),
          bottom: TabBar(
            onTap: (index) {
              setState(() {
                _currentTab = GroceryTabType.values[index];
              });
            },
            tabs: const [
              Tab(text: 'Grocery'),
              Tab(text: 'Search'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            GroceryTab(tabId: widget.tabId),
            SearchTab(tabId: widget.tabId),
          ],
        ),
      ),
    );
  }
}
