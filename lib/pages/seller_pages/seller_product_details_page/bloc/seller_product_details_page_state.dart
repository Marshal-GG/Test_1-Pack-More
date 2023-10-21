part of 'seller_product_details_page_bloc.dart';

sealed class SellerProductDetailsState extends Equatable {
  const SellerProductDetailsState();
  
  @override
  List<Object> get props => [];
}

final class SellerProductDetailsInitial extends SellerProductDetailsState {}

class SellerProductDetailsPageLoaded extends SellerProductDetailsState {}

class ProductDeletedState extends SellerProductDetailsState {}

class DeleteErrorState extends SellerProductDetailsState {}

// class ProductImageIndexChangedState extends SellerProductDetailsState {
//   final int newIndex;

//   ProductImageIndexChangedState(this.newIndex);

//   @override
//   List<Object> get props => [newIndex];
// }