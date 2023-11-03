import '../../../models/models.dart';

abstract class BaseProductRepository {
  Future<void> addProduct(Products product);
  Future<Products?> fetchProductByProductID(String productID);
  Future<List<Products>> fetchAllProducts();
  Future<List<Products>> fetchProductsByCategory(String selectedCategoryName);
  Future<void> deleteProduct(Products product);
  Future<void> tempAddProduct(Products product);
  
}
