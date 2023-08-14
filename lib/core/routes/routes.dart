import 'package:flutter/material.dart';
import 'package:test_1/core/widgets/image_viewer.dart';
import 'package:test_1/pages/add_product/add_product_page.dart';
import 'package:test_1/pages/auth_temp.dart';
import 'package:test_1/pages/product_details/product_details.dart';
import 'package:test_1/pages/home/home.dart';
import 'package:test_1/pages/profile/user_profile_page.dart';
import 'package:test_1/pages/test/picture.dart';
import 'package:test_1/pages/test/picture2.dart';

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
    case '/add-product-page':
      return MaterialPageRoute(
        builder: (_) => AddProductPage(),
        settings: settings,
      );
    case '/picture-test-page':
      return MaterialPageRoute(
        builder: (_) => PictureTest(),
        settings: settings,
      );
    case '/picture2-test-page':
      return MaterialPageRoute(
        builder: (_) => PictureTest2(),
        settings: settings,
      );
    case '/user-profile-page':
      return MaterialPageRoute(
        builder: (_) => UserProfilePage(),
        settings: settings,
      );
      case '/image-viewer-page':
      return MaterialPageRoute(
        builder: (_) => ImageViewerPage(),
        settings: settings,
      );

    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Text(
              'Page not found',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ),
        settings: settings,
      );
  }
}
