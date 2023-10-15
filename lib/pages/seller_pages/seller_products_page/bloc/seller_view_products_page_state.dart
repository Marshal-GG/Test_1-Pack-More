part of 'seller_view_products_page_bloc.dart';

sealed class SellerViewProductsPageState extends Equatable {
  @override
  List<Object> get props => [];
}

final class SellerViewProductsPageInitial extends SellerViewProductsPageState {

}

class SellerViewProductsPageLoaded extends SellerViewProductsPageState {
  final List<SellerProducts> products;

  SellerViewProductsPageLoaded({
    required this.products,
  });



  @override
  List<Object> get props => [products];
}
