import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/firebase/services/seller_product_services.dart';
import 'seller_product_details_event.dart';
import 'seller_product_details_state.dart';

class SellerProductDetailsBloc
    extends Bloc<SellerProductDetailsEvent, SellerProductDetailsState> {
  final SellerProductService _service;

  SellerProductDetailsBloc(this._service)
      : super(SellerProductDetailsInitial());

  int _currentIndex = 0;

  Stream<SellerProductDetailsState> mapEventToState(
    SellerProductDetailsEvent event,
  ) async* {
    if (event is DeleteProductEvent) {
      try {
        await _service.deleteProduct(event.product);
        yield ProductDeletedState();
      } catch (_) {
        yield DeleteErrorState();
      }
    }
    if (event is UpdateProductImageIndexEvent) {
      _currentIndex = event.newIndex;
      yield ProductImageIndexChangedState(_currentIndex);
    }
  } 
  
  void updateImageIndex(int newIndex) {
    add(UpdateProductImageIndexEvent(newIndex));
  }
}
