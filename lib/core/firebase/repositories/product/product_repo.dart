import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../models/models.dart';
import 'base_product_repo.dart';

class ProductRepository extends BaseProductRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  @override
  Future<void> addProduct(Products product) {
    return _firebaseFirestore.collection('products').add(product.toDocument());
  }

  @override
  Future<void> deleteProduct(Products product) async {
    await _firebaseFirestore
        .collection('products')
        .doc(product.productID)
        .delete();

    await _firebaseStorage
        .ref()
        .child('product_images/${product.productID}')
        .delete();
  }

  @override
  Future<Products?> fetchProductByProductID(String productID) async {
    final querySnapshot = await _firebaseFirestore
        .collection('products')
        .where('productID', isEqualTo: productID)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final doc = querySnapshot.docs.first;
      final product = Products.fromDocument(doc);
      return product;
    } else {
      return null;
    }
  }

  @override
  Future<List<Products>> fetchAllProducts() async {
    final querySnapshot = await _firebaseFirestore.collection('products').get();

    final products =
        querySnapshot.docs.map((doc) => Products.fromDocument(doc)).toList();
    return products;
  }

  @override
  Future<List<Products>> fetchProductsByCategory(
      String selectedCategoryName) async {
    final QuerySnapshot querySnapshot = await _firebaseFirestore
        .collection('products')
        .where('category', isEqualTo: selectedCategoryName)
        .get();

    final products =
        querySnapshot.docs.map((doc) => Products.fromDocument(doc)).toList();

    return products;
  }
  
  @override
  Future<void> tempAddProduct(Products product) {
    // TODO: implement tempAddProduct
    throw UnimplementedError();
  }


}
