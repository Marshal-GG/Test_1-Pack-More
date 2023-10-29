import 'package:flutter/material.dart';

class ReviewOrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review Your Order'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Summary',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // Display the order summary, including products, quantities, and total price.
            // You can use ListView, ListTile, or any other widget to display the items.

            SizedBox(height: 16),

            Text(
              'Shipping Address',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // Display the user's shipping address here.

            SizedBox(height: 16),

            Text(
              'Payment Method',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // Display the selected payment method (e.g., credit card, PayPal).

            SizedBox(height: 16),

            ElevatedButton(
              onPressed: () {
                // Handle the "Continue to Payment" button tap to navigate to the payment screen.
                // You may also want to pass order details to the payment screen.
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => PaymentPage(),
                //   ),
                // );
              },
              child: Text('Continue to Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
