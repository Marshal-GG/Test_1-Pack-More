import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';


import '../../pages/address_details_page/bloc/address_details_page_bloc.dart';
import '../../pages/buy_payment_confirmation_pages/check_out_page/bloc/check_out_page_bloc.dart';
import '../../pages/help_feeback_page/bloc/help_feedback_page_bloc.dart';
import '../../pages/home/bloc/home_page_bloc.dart';
import '../../pages/seller_pages/seller_product_details_page/bloc/seller_product_details_page_bloc.dart';
import '../../pages/seller_pages/seller_view_all_products_page/bloc/seller_view_products_page_bloc.dart';
import '../../pages/shopping_cart_page/bloc/shopping_cart_page_bloc.dart';
import '../../pages/view_all_products/bloc/view_all_products_bloc.dart';
import '../firebase/services/firebase_services.dart';
import '../firebase/services/categories_services.dart';
import '../firebase/services/help_feedback_services.dart';
import '../firebase/services/product_service.dart';
import '../firebase/services/seller_product_services.dart';
import '../models/theme_model.dart';
import '../models/drawer_selection_model.dart';
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
    child: AddressDetailsPage(),
  ),
];
