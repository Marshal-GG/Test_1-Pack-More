part of 'view_all_products_bloc.dart';

sealed class ViewAllProductsState extends Equatable {
  @override
  List<Object> get props => [];
}

final class ViewAllProductsInitial extends ViewAllProductsState {}

class ViewAllProductsLoaded extends ViewAllProductsState {
  final List<Products> products;
  ViewAllProductsLoaded({required this.products});

  @override
  List<Object> get props => [products];
}
