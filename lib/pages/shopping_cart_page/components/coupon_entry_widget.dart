import 'package:flutter/material.dart';

class CouponEntryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Enter coupon code:"),
          TextField(
            // Controller to capture user input
            controller: TextEditingController(),
            decoration: InputDecoration(
              hintText: "Enter coupon code",
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Verify and apply coupon logic here
                  // Update cart total if the coupon is valid
                  // Close the bottom sheet if needed
                },
                child: Text("Apply"),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
