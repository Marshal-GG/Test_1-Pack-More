import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/firebase/services/seller_product_services.dart';
import '../../../../core/models/seller_product_model.dart';

part 'seller_product_details_page_event.dart';
part 'seller_product_details_page_state.dart';

class SellerProductDetailsBloc
    extends Bloc<SellerProductDetailsEvent, SellerProductDetailsState> {
  final SellerProductService sellerproductService;

  SellerProductDetailsBloc({
    required this.sellerproductService,
  }) : super(SellerProductDetailsInitial()) {
    on<SellerProductDetailsPageCounterEvent>((event, emit) {
      emit(SellerProductDetailsPageLoaded());
    });

    on<DeleteProductEvent>((event, emit) async {
      try {
        await Future.delayed(Duration(seconds: 1));
        // await sellerproductService.deleteProduct(event.product);
        emit(ProductDeletedState());
      } catch (e) {
        emit(DeleteErrorState());
      }
    });
  }
}
