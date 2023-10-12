import 'package:flutter/material.dart';
import 'package:test_1/core/widgets/custom_drawer.dart';

class AdminPanelOptions extends StatelessWidget {
  const AdminPanelOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
      ),
      drawer: CustomDrawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Icon(
              Icons.admin_panel_settings_outlined,
              size: 64,
              color: Colors.greenAccent,
            ),
            Divider(),
            ListTile(
              tileColor: colorScheme.surfaceVariant.withOpacity(0.6),
              leading: Icon(
                Icons.production_quantity_limits_outlined,
                size: 24,
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                size: 24,
              ),
              title: Text(
                'Product Status Tracker',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/product-status-tracker-page');
              },
            ),
            SizedBox(height: 8),
            ListTile(
              tileColor: colorScheme.surfaceVariant.withOpacity(0.6),
              leading: Icon(
                Icons.help_outline,
                size: 24,
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                size: 24,
              ),
              title: Text(
                'Help & Feedback Tracker',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/help-feedback-tracker-page');
              },
            ),
          ],
        ),
      ),
    );
  }
}
