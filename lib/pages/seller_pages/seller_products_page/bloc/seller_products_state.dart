import '../seller_products_page.dart';

class SellerProductsState {
  final bool isLoading;
  final List<Products> products;

  SellerProductsState({
    required this.isLoading,
    required this.products,
  });

  SellerProductsState copyWith({
    bool? isLoading,
    List<Products>? products,
  }) {
    return SellerProductsState(
      isLoading: isLoading ?? this.isLoading,
      products: products ?? this.products,
    );
  }
}
