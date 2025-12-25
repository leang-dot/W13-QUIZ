import 'package:flutter/material.dart';

class GroceryTab extends StatelessWidget {
  final String tabId;
  const GroceryTab({super.key, required this.tabId});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'Grocery Tab ID: $tabId',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}