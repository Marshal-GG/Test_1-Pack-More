import 'package:flutter/material.dart';
import 'package:test_1/pages/admin_console/admin_console.dart';
import 'package:test_1/pages/auth_temp.dart';
import 'package:test_1/pages/details/details.dart';
import 'package:test_1/pages/home/home.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(
        builder: (_) => AuthTemp(),
        settings: settings,
      );
    case '/home-page':
      return MaterialPageRoute(
        builder: (_) => HomePage(),
        settings: settings,
      );
    case '/product-details-page':
      return MaterialPageRoute(
        builder: (_) => DetailsPage(),
        settings: settings,
      );
    case '/admin-console-page':
      return MaterialPageRoute(
        builder: (_) => AdminConsolePage(),
        settings: settings,
      );

    default:
      return MaterialPageRoute(
        builder: (_) =>
            const Scaffold(body: Center(child: Text('Page not found'))),
        settings: settings,
      );
  }
}
