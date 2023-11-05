import 'package:flutter/material.dart';

import 'routes_config.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  final Map<String, WidgetBuilder> routes = {
    '/': (_) => AuthTemp(),
    '/home-page': (_) => HomePage(),
    '/product-details-page': (_) => ProductDetailsPage(),
    '/add-product-page': (_) => AddProductPage(),
    '/view-all-products-page': (_) => ViewAllProductsPage(),
    '/user-profile-page': (_) => UserProfilePage(),
    '/image-viewer-page': (_) => ImageViewerPage(),
    '/seller-products-page': (_) => SellerViewProductsPage(),
    '/seller-product-details-page': (_) => SellerProductDetailsPage(),
    '/product-status-tracker-page': (_) => ProductStatusTrackerPage(),
    '/help-feedback-page': (_) => HelpFeedbackPage(),
    '/admin-panel-options-page': (_) => AdminPanelOptions(),
    '/help-feedback-tracker-page': (_) => HelpFeedbackTrackerPage(),
    '/shopping-cart-page': (_) => ShoppingCartPage(),
    '/check-out-page': (_) => CheckoutPage(),
    '/address-details-page': (_) => AddressDetailsPage(),
    '/payment-page': (_) => PaymentPage(),
  };

  final WidgetBuilder? builder = routes[settings.name];

  if (builder != null) {
    return MaterialPageRoute(
      builder: builder,
      settings: settings,
    );
  } else {
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

// Route<dynamic> generateRoute(RouteSettings settings) {
//   switch (settings.name) {
//     case '/':
//       return MaterialPageRoute(
//         builder: (_) => AuthTemp(),
//         settings: settings,
//       );
//     case '/home-page':
//       return MaterialPageRoute(
//         builder: (_) => HomePage(),
//         settings: settings,
//       );
//     case '/product-details-page':
//       return MaterialPageRoute(
//         builder: (_) => ProductDetailsPage(),
//         settings: settings,
//       );
//     case '/add-product-page':
//       return MaterialPageRoute(
//         builder: (_) => AddProductPage(),
//         settings: settings,
//       );
//     // case '/picture2-test-page':
//     //   return MaterialPageRoute(
//     //     builder: (_) => PictureTest2(),
//     //     settings: settings,
//     //   );
//     case '/view-all-products-page':
//       return MaterialPageRoute(
//         builder: (_) => ViewAllProductsPage(),
//         settings: settings,
//       );
//     case '/user-profile-page':
//       return MaterialPageRoute(
//         builder: (_) => UserProfilePage(),
//         settings: settings,
//       );
//     case '/image-viewer-page':
//       return MaterialPageRoute(
//         builder: (_) => ImageViewerPage(),
//         settings: settings,
//       );
//     case '/seller-products-page':
//       return MaterialPageRoute(
//         builder: (_) => SellerViewProductsPage(),
//         settings: settings,
//       );
//     case '/seller-product-details-page':
//       return MaterialPageRoute(
//         builder: (_) => SellerProductDetailsPage(),
//         settings: settings,
//       );
//     case '/product-status-tracker-page':
//       return MaterialPageRoute(
//         builder: (_) => ProductStatusTrackerPage(),
//         settings: settings,
//       );
//     case '/help-feedback-page':
//       return MaterialPageRoute(
//         builder: (_) => HelpFeedbackPage(),
//         settings: settings,
//       );
//     case '/admin-panel-options-page':
//       return MaterialPageRoute(
//         builder: (_) => AdminPanelOptions(),
//         settings: settings,
//       );
//     case '/help-feedback-tracker-page':
//       return MaterialPageRoute(
//         builder: (_) => HelpFeedbackTrackerPage(),
//         settings: settings,
//       );
//     case '/shopping-cart-page':
//       return MaterialPageRoute(
//         builder: (_) => ShoppingCartPage(),
//         settings: settings,
//       );
//     case '/check-out-page':
//       return MaterialPageRoute(
//         builder: (_) => CheckoutPage(),
//         settings: settings,
//       );
//     case '/address-details-page':
//       return MaterialPageRoute(
//         builder: (_) => AddressDetailsPage(),
//         settings: settings,
//       );case '/payment-page':
//       return MaterialPageRoute(
//         builder: (_) => PaymentPage(),
//         settings: settings,
//       );

//     default:
//       return MaterialPageRoute(
//         builder: (_) => Scaffold(
//           appBar: AppBar(),
//           body: Center(
//             child: Text(
//               'Page not found',
//               style: TextStyle(fontSize: 24),
//             ),
//           ),
//         ),
//         settings: settings,
//       );
//   }
// }
