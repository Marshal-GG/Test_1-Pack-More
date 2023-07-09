import 'package:flutter/material.dart';

class ProductReviewPage extends StatelessWidget {
  final String name;
  final double price;
  final String description;
  final int quantity;
  final String category;

  ProductReviewPage({
    required this.name,
    required this.price,
    required this.description,
    required this.quantity,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Review'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Name: $name',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Price: $price',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Description: $description',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Quantity: $quantity',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Category: $category',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add your logic here for further actions
              },
              child: Text('Confirm'),
            ),
          ],
        ),
      ),
    );
  }
}
