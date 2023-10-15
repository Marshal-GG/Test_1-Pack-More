part of 'view_all_products_bloc.dart';

abstract class ViewAllProductsEvent extends Equatable {
  const ViewAllProductsEvent();

  @override
  List<Object> get props => [];
}

class ViewAllProductsPageCounterEvent extends ViewAllProductsEvent {}

class ScrollListenerEvent extends ViewAllProductsEvent {}