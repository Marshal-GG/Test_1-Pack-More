import 'package:flutter/material.dart';

import 'routes_config.dart';

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
    // case '/picture2-test-page':
    //   return MaterialPageRoute(
    //     builder: (_) => PictureTest2(),
    //     settings: settings,
    //   );
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
    case '/shopping-cart-page':
      return MaterialPageRoute(
        builder: (_) => ShoppingCartPage(),
        settings: settings,
      );
    case '/check-out-page':
      return MaterialPageRoute(
        builder: (_) => CheckoutPage(),
        settings: settings,
      );
    case '/address-details-page':
      return MaterialPageRoute(
        builder: (_) => AddressDetailsPage(),
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
