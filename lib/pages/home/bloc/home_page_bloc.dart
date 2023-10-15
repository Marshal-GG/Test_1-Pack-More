import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/firebase/firebase_services.dart';
import '../../../core/firebase/services/categories_services.dart';
import '../../../core/firebase/services/product_service.dart';
import '../../../core/models/product_model.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final FirebaseService firebaseService;
  final CategoryService categoryService;
  final ProductsService productsService;
  List<Map<String, dynamic>> categories = [];
  List<Products> products = [];
  Map<String, List<Products>> productImageCache = {};
  String selectedCategoryName = '';
  int newIndex = 0;

  HomePageBloc({
    required this.firebaseService,
    required this.categoryService,
    required this.productsService,
  }) : super(
          HomePageInitial(
            categories: [],
            selectedIndex: 0,
            products: [],
          )
        ) {
    on<HomePageEvent>((event, emit) async {
      categories = await categoryService.fetchCategories();
      selectedCategoryName =
          newIndex < categories.length ? categories[newIndex]['name'] : '';

      if (productImageCache.containsKey(selectedCategoryName)) {
        products =
            await firebaseService.fetchProductsByCategory(selectedCategoryName);
        emit((state as HomePageInitial).copyWith(
          categories: categories,
          selectedIndex: newIndex,
          products: products,
        ));

        emit((state as HomePageInitial).copyWith(
          products: productImageCache[selectedCategoryName],
        ));
      } else {
        products =
            await firebaseService.fetchProductsByCategory(selectedCategoryName);
        emit((state as HomePageInitial).copyWith(
          categories: categories,
          selectedIndex: newIndex,
          products: products,
        ));

        products += await productsService.fetchProductImageUrls(
            products, firebaseService);
        productImageCache[selectedCategoryName] = products;
        emit((state as HomePageInitial).copyWith(
          products: products,
        ));
      }
    });
    
    on<ChangeCategoriesEvent>((event, emit) async {
      newIndex = event.newIndex;
    });
  }
}
