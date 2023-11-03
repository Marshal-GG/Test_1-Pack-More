import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_1/core/firebase/repositories/category/category_repository.dart';
import 'package:test_1/core/firebase/repositories/product/product_repo.dart';
import 'package:test_1/core/models/models.dart';

import '../../../core/firebase/services/firebase_services.dart';
import '../../../core/firebase/services/categories_services.dart';
import '../../../core/firebase/services/product_service.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final FirebaseService firebaseService;
  final CategoryService categoryService;
  final ProductsService productsService;
  final CategoryRepository categoryRepository = CategoryRepository();
  final ProductRepository productRepository = ProductRepository();

  List<Category> categories = [];
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

        categories = await categoryRepository.fetchAllCategories();
        selectedCategoryName =
            newIndex < categories.length ? categories[newIndex].name : '';

        if (productCache.containsKey(selectedCategoryName)) {
          products = await productRepository
              .fetchProductsByCategory(selectedCategoryName);

          emit((state as HomePageLoaded).copyWith(
            categories: categories,
            selectedIndex: newIndex,
            products: productCache[selectedCategoryName],
          ));
        } else {
          products = await productRepository
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
