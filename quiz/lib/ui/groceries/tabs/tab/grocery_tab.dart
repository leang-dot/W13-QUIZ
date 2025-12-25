import 'package:flutter/material.dart';
import 'package:quiz/data/mock_grocery_repository.dart';
import 'package:quiz/models/grocery.dart';

class GroceryTab extends StatelessWidget {
  final String tabId;
  const GroceryTab({super.key, required this.tabId});

  @override
  Widget build(BuildContext context) {
    Grocery? grocery;
    try {
      grocery = dummyGroceryItems.firstWhere((g) => g.id == tabId);
    } catch (e) {
      grocery = null;
    }

    if (grocery == null) {
      return const Center(child: Text('Grocery item not found'));
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 24, height: 24, color: grocery.category.color),
              const SizedBox(width: 8),
              Text(
                grocery.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Quantity: ${grocery.quantity}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            'Category: ${grocery.category.label}',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
