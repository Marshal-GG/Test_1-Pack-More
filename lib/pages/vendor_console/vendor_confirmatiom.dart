import 'package:flutter/material.dart';
import 'package:test_1/pages/vendor_console/vendor_page.dart';

class VendorConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vendor Confirmation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Vendor Confirmation Page',
              style: TextStyle(fontSize: 24.0),
            ),
            ElevatedButton(
              child: Text('Confirm Vendor'),
              onPressed: () {
                // Add vendor confirmation logic here

                // Once vendor is confirmed, navigate to the VendorPage
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VendorPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
