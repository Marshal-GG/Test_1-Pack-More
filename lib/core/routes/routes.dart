import 'package:flutter/material.dart';
import 'package:test_1/core/widgets/image_viewer.dart';
import 'package:test_1/pages/admin_panel/admin_panel_options.dart';
import 'package:test_1/pages/admin_panel/help_feedback_tracker.dart';
import 'package:test_1/pages/admin_panel/product_status_tracker.dart';
import 'package:test_1/pages/help_feeback_page/help_feedback_page.dart';
import 'package:test_1/pages/seller_pages/seller_add_product_page/seller_add_product_page.dart';
import 'package:test_1/pages/auth_temp.dart';
import 'package:test_1/pages/product_details/product_details.dart';
import 'package:test_1/pages/home/home.dart';
import 'package:test_1/pages/profile/user_profile_page.dart';
import 'package:test_1/pages/seller_pages/seller_product_details_page/seller_product_details_page.dart';
import 'package:test_1/pages/test/picture.dart';
import 'package:test_1/pages/test/picture2.dart';
import 'package:test_1/pages/seller_pages/seller_products_page/seller_products_page.dart';

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
    case '/seller-products-page':
      return MaterialPageRoute(
        builder: (_) => SellerProductsPage(),
        settings: settings,
      );
    // case '/seller-product-details-page':
    //   return MaterialPageRoute(
    //     builder: (_) => SellerProductDetailsPage(),
    //     settings: settings,
    //   );
    case '/product-status-tracker-page':
      return MaterialPageRoute(
        builder: (_) => ProductStatusTrackerPage(),
        settings: settings,
      );
    case '/help-feedback-page':
      return MaterialPageRoute(
        builder: (_) => HelpFeedbackPage(),
        settings: settings,
      );
    case '/admin-panel-options-page':
      return MaterialPageRoute(
        builder: (_) => AdminPanelOptions(),
        settings: settings,
      );
    case '/help-feedback-tracker-page':
      return MaterialPageRoute(
        builder: (_) => HelpFeedbackTrackerPage(),
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
