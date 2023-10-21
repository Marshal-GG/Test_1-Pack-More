import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/firebase/services/firebase_services.dart';
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
  Map<String, List<Products>> productCache = {};
  String selectedCategoryName = '';
  int newIndex = 0;
  bool isLoading = false;

  HomePageBloc({
    required this.firebaseService,
    required this.categoryService,
    required this.productsService,
  }) : super(HomePageInitial()) {
    on<HomePageCounterEvent>((event, emit) async {
      if (!isLoading) {
        isLoading = true;
        categories = await categoryService.fetchCategories();
        selectedCategoryName =
            newIndex < categories.length ? categories[newIndex]['name'] : '';

        if (productCache.containsKey(selectedCategoryName)) {
          products = await firebaseService
              .fetchProductsByCategory(selectedCategoryName);
          emit((state as HomePageLoaded).copyWith(
            categories: categories,
            selectedIndex: newIndex,
            products: productCache[selectedCategoryName],
          ));
        } else {
          products = await firebaseService
              .fetchProductsByCategory(selectedCategoryName);
          emit(HomePageLoaded(
            categories: categories,
            selectedIndex: newIndex,
            products: products,
          ));

          products = await productsService.fetchProductImageUrls(
            products,
            firebaseService,
          );
          productCache[selectedCategoryName] = products;
          emit((state as HomePageLoaded).copyWith(
            categories: categories,
            selectedIndex: newIndex,
            products: products,
          ));
        }
        isLoading = false;
      }
    });

    on<ChangeCategoriesEvent>((event, emit) async {
      if (state is HomePageLoaded && !isLoading) {
        newIndex = event.newIndex;
        add(HomePageCounterEvent());
      }
    });
  }
}
