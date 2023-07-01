import 'package:flutter/material.dart';
import 'package:test_1/pages/auth_temp.dart';
import 'package:test_1/pages/product_details/product_details.dart';
import 'package:test_1/pages/home/home.dart';
import 'package:test_1/pages/test/picture.dart';

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
        builder: (_) => ProductDetailsPage(),
        settings: settings,
      );
    case '/picture-test-page':
      return MaterialPageRoute(
        builder: (_) => PictureTest(),
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