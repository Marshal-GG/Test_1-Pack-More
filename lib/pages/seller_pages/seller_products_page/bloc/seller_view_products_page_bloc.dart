import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/firebase/firebase_services.dart';
import '../../../../core/firebase/services/seller_product_services.dart';
import '../../../../core/models/seller_product_model.dart';

part 'seller_view_products_page_event.dart';
part 'seller_view_products_page_state.dart';

class SellerViewProductsPageBloc
    extends Bloc<SellerViewProductsPageEvent, SellerViewProductsPageState> {
  final FirebaseService firebaseService;
  final SellerProductService sellerproductService;
  List<SellerProducts> products = [];
  String userUid = FirebaseAuth.instance.currentUser!.uid;
  int page = 1;

  SellerViewProductsPageBloc({
    required this.firebaseService,
    required this.sellerproductService,
  }) : super(SellerViewProductsPageInitial()) {
    on<SellerViewProductsPageCounterEvent>((event, emit) async {
      products += await sellerproductService.getUserProducts(userUid);
      emit(SellerViewProductsPageLoaded(products: products));
      print('Got products ${products.length}');

      products = await sellerproductService.fetchProductImageUrls(
          products, firebaseService);
      emit(SellerViewProductsPageLoaded(products: products));
      print('Got Images ${products.length}');
    });

  }
}
