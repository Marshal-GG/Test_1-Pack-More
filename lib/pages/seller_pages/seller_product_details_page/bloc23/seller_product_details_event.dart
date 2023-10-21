import 'package:equatable/equatable.dart';

import '../../../../core/models/seller_product_model.dart';


abstract class SellerProductDetailsEvent extends Equatable {
  const SellerProductDetailsEvent();

  @override
  List<Object?> get props => [];
}

class DeleteProductEvent extends SellerProductDetailsEvent {
  final SellerProducts product;

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