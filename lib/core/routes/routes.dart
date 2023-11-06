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
    '/orders-page': (_) => OrdersPage(),
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
