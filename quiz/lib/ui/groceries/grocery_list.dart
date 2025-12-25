import 'package:flutter/material.dart';
import '../../data/mock_grocery_repository.dart';
import '../../models/grocery.dart';
import 'grocery_form.dart';
import 'tabs/tab_detail.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  // Current active tab index when using IndexedStack
  int _currentIndex = 0;

  void onCreate() async {
    // Navigate to the form screen using the Navigator push
    Grocery? newGrocery = await Navigator.push<Grocery>(
      context,
      MaterialPageRoute(builder: (context) => const GroceryForm()),
    );
    if (newGrocery != null) {
      setState(() {
        dummyGroceryItems.add(newGrocery);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [IconButton(onPressed: onCreate, icon: const Icon(Icons.add))],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [_AllGroceriesTab(), _SearchGroceriesTab()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Groceries',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
      ),
    );
  }
}

class _AllGroceriesTab extends StatelessWidget {
  const _AllGroceriesTab();

  @override
  Widget build(BuildContext context) {
    if (dummyGroceryItems.isEmpty) {
      return const Center(child: Text('No items added yet.'));
    }

    return ListView.builder(
      itemCount: dummyGroceryItems.length,
      itemBuilder: (context, index) {
        final grocery = dummyGroceryItems[index];
        return GroceryTile(
          grocery: grocery,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TabDetail(tabId: grocery.id),
              ),
            );
          },
        );
      },
    );
  }
}

class _SearchGroceriesTab extends StatefulWidget {
  const _SearchGroceriesTab();

  @override
  State<_SearchGroceriesTab> createState() => _SearchGroceriesTabState();
}

class _SearchGroceriesTabState extends State<_SearchGroceriesTab> {
  final _controller = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _query.isEmpty
        ? <Grocery>[]
        : dummyGroceryItems
              .where((g) => g.name.toLowerCase().contains(_query.toLowerCase()))
              .toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'Search groceries by name',
              border: UnderlineInputBorder(),
            ),
            onChanged: (v) => setState(() => _query = v),
          ),
        ),
        if (_query.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                _query[0].toUpperCase(),
                style: const TextStyle(color: Colors.black54),
              ),
            ),
          ),
        const Divider(height: 1),
        Expanded(
          child: filtered.isEmpty
              ? Center(
                  child: _query.isEmpty
                      ? const Text('Type to filter groceries')
                      : const Text('No matching groceries'),
                )
              : ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final grocery = filtered[index];
                    return GroceryTile(
                      grocery: grocery,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TabDetail(tabId: grocery.id),
                          ),
                        );
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class GroceryTile extends StatelessWidget {
  const GroceryTile({super.key, required this.grocery, this.onTap});

  final Grocery grocery;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(width: 15, height: 15, color: grocery.category.color),
      title: Text(grocery.name),
      trailing: Text(grocery.quantity.toString()),
    );
  }
}
