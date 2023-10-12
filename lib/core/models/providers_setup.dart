import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:test_1/core/controller/bloc/category_selection_bloc.dart';
import 'package:test_1/core/firebase/services/categories_services.dart';
import 'package:test_1/core/firebase/services/product_service.dart';
import 'package:test_1/pages/seller_pages/seller_products_page/bloc/seller_products_bloc.dart';
import 'package:test_1/core/firebase/firebase_services.dart';
import 'package:test_1/pages/home/bloc/home_page_bloc.dart';
// import 'package:test_1/pages/product_details/bloc/seller_product_details_bloc.dart';
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
      categorySelectionBloc: CategorySelectionBloc(),
      categoryService: CategoryService(),
      productsService: ProductsService(),
    ),
  ),
];
