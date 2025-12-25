import 'package:flutter/material.dart';

class SearchTab extends StatelessWidget {
  final String tabId;
  const SearchTab({super.key, required this.tabId});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'Search Tab ID: $tabId',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}