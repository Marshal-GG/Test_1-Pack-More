import 'package:flutter/material.dart';

import '../../pages/admin_panel/admin_panel_options.dart';
import '../../pages/admin_panel/help_feedback_tracker_page/help_feedback_tracker_page.dart';
import '../../pages/admin_panel/product_status_tracker.dart';
import '../../pages/auth_temp.dart';
import '../../pages/help_feeback_page/help_feedback_page.dart';
import '../../pages/home/home.dart';
import '../../pages/product_details/product_details.dart';
import '../../pages/profile/user_profile_page.dart';
import '../../pages/seller_pages/seller_add_product_page/seller_add_product_page.dart';
import '../../pages/seller_pages/seller_product_details_page/seller_product_details_page.dart';
import '../../pages/seller_pages/seller_view_all_products_page/seller_view_all_products_page.dart';

import '../../pages/test/dialoge_test.dart';
import '../../pages/test/picture2.dart';
import '../../pages/view_all_products/view_all_products.dart';
import '../widgets/image_viewer.dart';

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
    case '/picture2-test-page':
      return MaterialPageRoute(
        builder: (_) => PictureTest2(),
        settings: settings,
      );
    case '/view-all-products-page':
      return MaterialPageRoute(
        builder: (_) => ViewAllProductsPage(),
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
        builder: (_) => SellerViewProductsPage(),
        settings: settings,
      );
    case '/seller-product-details-page':
      return MaterialPageRoute(
        builder: (_) => SellerProductDetailsPage(),
        settings: settings,
      );
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
