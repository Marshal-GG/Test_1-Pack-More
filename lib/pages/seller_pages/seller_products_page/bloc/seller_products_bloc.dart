import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_1/pages/seller_pages/seller_products_page/bloc/seller_products_event.dart';
import 'package:test_1/pages/seller_pages/seller_products_page/bloc/seller_products_state.dart';
import 'package:test_1/core/firebase/services/seller_product_services.dart';

import '../seller_products_page.dart';
import '../../../../core/firebase/firebase_services.dart';

class SellerProductsBloc
    extends Bloc<SellerProductsEvent, SellerProductsState> {
  final FirebaseService firebaseService;
  final SellerProductService sellerproductService;

  SellerProductsBloc({
    required this.sellerproductService,
    required this.firebaseService,
  }) : super(
          SellerProductsState(
            isLoading: true,
            products: [],
          ),
        ) {
    on<FetchSellerProductsEvent>((event, emit) async {
      // Set isLoading to true initially
      emit(state.copyWith(isLoading: true));

      try {
        String userUid = FirebaseAuth.instance.currentUser!.uid;
        List<Products> products =
            await sellerproductService.getUserProducts(userUid);

        // Perform the state update in a more controlled manner
        emit(state.copyWith(isLoading: false, products: products));
      } catch (e) {
        // Handle the error and perform the state update
        emit(state.copyWith(isLoading: false, products: []));
      }
    });
  }
}
