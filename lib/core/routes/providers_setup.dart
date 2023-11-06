import 'package:provider/single_child_widget.dart';


import '../../pages/view_all_products/bloc/view_all_products_bloc.dart';
import 'routes_config.dart';

List<SingleChildWidget> providers = [
  // Providers related to UI
  ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
  ChangeNotifierProvider<DrawerSelectionState>(
      create: (_) => DrawerSelectionState()),

  BlocProvider<SellerViewProductsPageBloc>(
    create: (_) => SellerViewProductsPageBloc(
      firebaseService: FirebaseService(),
      sellerproductService: SellerProductService(),
    )..add(ReloadProductsEvent()),
    child: SellerViewProductsPage(),
  ),
  BlocProvider<SellerProductDetailsBloc>(
    create: (_) => SellerProductDetailsBloc(
      sellerproductService: SellerProductService(),
    )..add(SellerProductDetailsPageCounterEvent()),
    child: SellerProductDetailsPage(),
  ),
  BlocProvider<HomePageBloc>(
    create: (_) => HomePageBloc(
      firebaseService: FirebaseService(),
      categoryService: CategoryService(),
      productsService: ProductsService(),
    )..add(HomePageCounterEvent()),
    child: HomePage(),
  ),
  BlocProvider<ViewAllProductsBloc>(
    create: (_) => ViewAllProductsBloc(
      firebaseService: FirebaseService(),
      productsService: ProductsService(),
    )..add(ViewAllProductsPageCounterEvent()),
    child: ViewAllProductsPage(),
  ),
  BlocProvider<HelpFeedbackPageBloc>(
    create: (_) =>
        HelpFeedbackPageBloc(helpFeedbackService: HelpFeedbackService()),
    child: ViewAllProductsPage(),
  ),
  BlocProvider<ShoppingCartPageBloc>(
    create: (_) => ShoppingCartPageBloc(),
    child: ShoppingCartPage(),
  ),
  BlocProvider<CheckoutPageBloc>(
    create: (_) => CheckoutPageBloc(),
    child: CheckoutPage(),
  ),
  BlocProvider<AddressDetailsPageBloc>(
    create: (_) => AddressDetailsPageBloc(),
  ),
  BlocProvider<PaymentPageBloc>(
    create: (_) => PaymentPageBloc(),
  ),
  BlocProvider<OrdersPageBloc>(
    create: (_) => OrdersPageBloc(),
  ),
];
