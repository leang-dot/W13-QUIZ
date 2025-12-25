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
    return Scaffold(
      appBar: AppBar(title: const Text('Details')),
      body: IndexedStack(
        index: _currentTab.index,
        children: [
          GroceryTab(tabId: widget.tabId),
          SearchTab(tabId: widget.tabId),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTab.index,
        onTap: (index) {
          setState(() {
            _currentTab = GroceryTabType.values[index];
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Grocery'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
      ),
    );
  }
}
