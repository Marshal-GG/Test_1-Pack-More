part of 'seller_view_products_page_bloc.dart';

abstract class SellerViewProductsPageEvent extends Equatable {
  const SellerViewProductsPageEvent();

  @override
  List<Object> get props => [];
}

class SellerViewProductsPageCounterEvent extends SellerViewProductsPageEvent {}

class ScrollListenerEvent extends SellerViewProductsPageEvent {}

class ReloadProductsEvent extends SellerViewProductsPageEvent {}
