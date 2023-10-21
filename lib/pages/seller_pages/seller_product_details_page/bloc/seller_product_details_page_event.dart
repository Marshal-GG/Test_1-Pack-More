part of 'seller_product_details_page_bloc.dart';

sealed class SellerProductDetailsEvent extends Equatable {
  const SellerProductDetailsEvent();

  @override
  List<Object> get props => [];
}

class SellerProductDetailsPageCounterEvent extends SellerProductDetailsEvent {}

class DeleteProductEvent extends SellerProductDetailsEvent {
  final SellerProducts product;

  DeleteProductEvent({required this.product});

  @override
  List<Object> get props => [product];
}

// class UpdateProductImageIndexEvent extends SellerProductDetailsEvent {
//   final int newIndex;

//   UpdateProductImageIndexEvent({required this.newIndex});

//   @override
//   List<Object> get props => [newIndex];
// }