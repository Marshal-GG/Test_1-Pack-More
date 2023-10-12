import 'package:equatable/equatable.dart';

import '../../seller_products_page/seller_products_page.dart';


abstract class SellerProductDetailsEvent extends Equatable {
  const SellerProductDetailsEvent();

  @override
  List<Object?> get props => [];
}

class DeleteProductEvent extends SellerProductDetailsEvent {
  final Products product;

  DeleteProductEvent(this.product);

  @override
  List<Object?> get props => [product];
}

class UpdateProductImageIndexEvent extends SellerProductDetailsEvent {
  final int newIndex;

  UpdateProductImageIndexEvent(this.newIndex);

  @override
  List<Object?> get props => [newIndex];
}