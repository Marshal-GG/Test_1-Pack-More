class SellerProductDetailsState {}

class SellerProductDetailsInitial extends SellerProductDetailsState {}

class ProductDeletedState extends SellerProductDetailsState {}

class DeleteErrorState extends SellerProductDetailsState {}

class ProductImageIndexChangedState extends SellerProductDetailsState {
  final int newIndex;

  ProductImageIndexChangedState(this.newIndex);

  List<Object?> get props => [newIndex];
}