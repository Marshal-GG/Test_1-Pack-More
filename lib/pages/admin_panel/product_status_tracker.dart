import 'package:flutter/material.dart';
import 'package:test_1/core/widgets/custom_drawer.dart';

class ProductStatusTrackerPage extends StatelessWidget {
  const ProductStatusTrackerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product Status Tracker')),
      drawer: CustomDrawerWidget(),
      body: Column(),
    );
  }
}
