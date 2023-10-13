import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_1/core/models/product_model.dart';

import '../../../core/firebase/firebase_services.dart';
import '../../../core/firebase/services/product_service.dart';

part 'view_all_products_event.dart';
part 'view_all_products_state.dart';

class ViewAllProductsBloc
    extends Bloc<ViewAllProductsEvent, ViewAllProductsState> {
  final FirebaseService firebaseService;
  final ProductsService productsService;
  bool isFetchingMoreProducts = false;
  int page = 1;
  List<Products> products = [];

  ViewAllProductsBloc({
    required this.firebaseService,
    required this.productsService,
  }) : super(ViewAllProductsInitial(products: [])) {
    on<ViewAllProductsEvent>((event, emit) async {
      products += await firebaseService.fetchProductsByPages(page);
      emit(ViewAllProductsInitial(products: products));

      products += await productsService.fetchProductImageUrls(
          products, firebaseService);
      emit(ViewAllProductsInitial(products: products));
    });

    on<ScrollListenerEvent>((event, emit) async {
      if (!isFetchingMoreProducts) {
        isFetchingMoreProducts = true;
        page++;

        add(ViewAllProductsEvent());

        isFetchingMoreProducts = false;
      }
    });
  }
}
