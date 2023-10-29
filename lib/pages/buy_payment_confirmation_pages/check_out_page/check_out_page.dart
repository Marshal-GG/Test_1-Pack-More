import 'package:flutter/material.dart';

class CheckOutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Review Your Order'),
            // Display the order items and total price
            // Allow users to enter shipping and payment information
            // Add a "Place Order" button
          ],
        ),
      ),
    );
  }
}
