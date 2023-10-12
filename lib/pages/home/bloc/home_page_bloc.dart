import 'package:bloc/bloc.dart';
import 'package:test_1/core/controller/bloc/category_selection_bloc.dart';
import 'package:test_1/core/firebase/firebase_services.dart';
import 'package:test_1/core/firebase/services/categories_services.dart';
import 'package:test_1/core/firebase/services/product_service.dart';

import '../../../core/models/product_model.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final FirebaseService firebaseService;
  final CategorySelectionBloc categorySelectionBloc;
  final CategoryService categoryService;
  final ProductsService productsService;

  HomePageBloc({
    required this.firebaseService,
    required this.categorySelectionBloc,
    required this.categoryService,
    required this.productsService,
  }) : super(
          HomePageState(
            selectedIndex: 0,
            categories: [],
            products: [],
            selectedCategoryName: '',
          ),
        ) {
    on<FetchCategoriesEvent>(
      (event, emit) async {
        List<Map<String, dynamic>> categories =
            await categoryService.fetchCategories();
        final selectedCategoryName = event.newIndex < state.categories.length
            ? state.categories[event.newIndex]['name']
            : '';

        emit(state.copyWith(
          selectedIndex: event.newIndex,
          selectedCategoryName: selectedCategoryName,
          categories: categories,
        ));
        add(FetchProductsByCategoryEvent(selectedCategoryName));
      },
    );

    categorySelectionBloc.stream.listen((selectedCategoryIndex) {
      (state.copyWith(selectedIndex: selectedCategoryIndex));
    });

    on<FetchProductsByCategoryEvent>(
      (event, emit) async {
        List<Products> products = await firebaseService
            .fetchProductsByCategory(state.selectedCategoryName);
        emit(state.copyWith(products: products));
        add(FetchImageUrlsEvent(products));
      },
    );

    on<FetchImageUrlsEvent>(
      (event, emit) async {
        List<Products> products = event.products;
        await productsService.fetchProductImageUrls(products, firebaseService);
        emit(state.copyWith(products: products));
      },
    );
  }
}
