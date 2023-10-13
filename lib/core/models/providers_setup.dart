import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../pages/home/bloc/home_page_bloc.dart';
import '../../pages/home/home.dart';
import '../../pages/seller_pages/seller_products_page/bloc/seller_products_bloc.dart';
import '../../pages/view_all_products/bloc/view_all_products_bloc.dart';
import '../../pages/view_all_products/view_all_products.dart';
import '../firebase/firebase_services.dart';
import '../firebase/services/categories_services.dart';
import '../firebase/services/product_service.dart';
import '../firebase/services/seller_product_services.dart';
import '../models/theme_model.dart';
import 'drawer_selection_model.dart';

List<SingleChildWidget> providers = [
  // Providers related to UI
  ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
  ChangeNotifierProvider<DrawerSelectionState>(
      create: (_) => DrawerSelectionState()),

  BlocProvider<SellerProductsBloc>(
    create: (_) => SellerProductsBloc(
        firebaseService: FirebaseService(),
        sellerproductService: SellerProductService()),
  ),

  // BlocProvider<SellerProductDetailsBloc>(
  //   create: (_) => SellerProductDetailsBloc(SellerProductService()),
  // ),
  BlocProvider<HomePageBloc>(
    create: (_) => HomePageBloc(
      firebaseService: FirebaseService(),
      categoryService: CategoryService(),
      productsService: ProductsService(),
    )..add(HomePageEvent()),
    child: HomePage(),
  ),
  BlocProvider<ViewAllProductsBloc>(
    create: (_) => ViewAllProductsBloc(
      firebaseService: FirebaseService(),
      productsService: ProductsService(),
    )..add(ViewAllProductsEvent()),
    child: ViewAllProductsPage(),
  )
];
