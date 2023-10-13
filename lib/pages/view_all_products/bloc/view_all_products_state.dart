part of 'view_all_products_bloc.dart';

sealed class ViewAllProductsState extends Equatable {
  @override
  List<Object> get props => [];
}

final class ViewAllProductsInitial extends ViewAllProductsState {
  final List<Products> products;
  ViewAllProductsInitial({required this.products});

  @override
  List<Object> get props => [products];
}