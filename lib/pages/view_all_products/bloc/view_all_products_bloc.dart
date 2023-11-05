import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_1/core/models/product_model.dart';

import '../../../core/firebase/services/firebase_services.dart';
import '../../../core/firebase/services/product_service.dart';

part 'view_all_products_event.dart';
part 'view_all_products_state.dart';

class ViewAllProductsBloc
    extends Bloc<ViewAllProductsEvent, ViewAllProductsState> {
  final FirebaseService firebaseService;
  final ProductsService productsService;
  int page = 1;
  List<Products> products = [];
  bool isLoading = false;

  ViewAllProductsBloc({
    required this.firebaseService,
    required this.productsService,
  }) : super(ViewAllProductsInitial()) {
    on<ViewAllProductsPageCounterEvent>((event, emit) async {
      if (!isLoading) {
        isLoading = true;
        products += await firebaseService.fetchProductsByPages(page);
        emit(ViewAllProductsLoaded(products: products));

        products = await productsService.fetchProductImageUrls(
            products, firebaseService);
        emit(ViewAllProductsLoaded(products: products));
        isLoading = false;
      }
    });

    on<ViewAllProductsScrollListenerEvent>((event, emit) {
      if (state is ViewAllProductsLoaded && !isLoading) {
        page++;
        add(ViewAllProductsPageCounterEvent());
      }
    });
  }
}
