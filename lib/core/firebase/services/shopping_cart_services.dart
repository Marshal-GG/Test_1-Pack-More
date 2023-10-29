import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/product_model.dart';
import '../../models/shopping_cart_model.dart';

class ShoppingCartService {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('Users');
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');
  String userUid = FirebaseAuth.instance.currentUser!.uid;

  Future<void> addToCart(Products product, int quantity) async {
    try {
      CollectionReference cartCollection =
          usersCollection.doc(userUid).collection('Cart');

      // Check if the product is already in the cart
      QuerySnapshot query = await cartCollection
          .where('productID', isEqualTo: product.productID)
          .get();

      if (query.docs.isNotEmpty) {
        // Product is already in the cart, update the quantity
        final cartItem = query.docs.first;
        await cartCollection.doc(cartItem.id).update({
          'quantity': cartItem['quantity'] + quantity,
        });
      } else {
        // Product is not in the cart, add it
        await cartCollection.add({
          'productID': product.productID,
          'quantity': quantity,
        });
      }
    } catch (e) {
      print('Error adding to cart: $e');
    }
  }

  Future<List<ShoppingCart>> getCartItems() async {
    List<ShoppingCart> cartItems = [];

    try {
      CollectionReference cartCollection =
          usersCollection.doc(userUid).collection('Cart');

      QuerySnapshot query = await cartCollection.get();

      if (query.docs.isNotEmpty) {
        cartItems = query.docs.map((doc) {
          return ShoppingCart(
            productID: doc['productID'],
            quantity: doc['quantity'],
          );
        }).toList();
      }
    } catch (e) {
      print('Error getting cart items: $e');
    }

    return cartItems;
  }

  Future<void> updateCartProductQuantity(
      String productID, int newQuantity) async {
    try {
      CollectionReference cartCollection =
          usersCollection.doc(userUid).collection('Cart');

      QuerySnapshot query =
          await cartCollection.where('productID', isEqualTo: productID).get();

      if (query.docs.isNotEmpty) {
        final cartItem = query.docs.first;
        await cartCollection.doc(cartItem.id).update({
          'quantity': newQuantity,
        });
      }
    } catch (e) {
      print('Error updating cart product quantity: $e');
    }
  }

  Future<void> removeFromCart(Products product) async {
    try {
      CollectionReference cartCollection =
          usersCollection.doc(userUid).collection('Cart');

      QuerySnapshot query = await cartCollection
          .where('productID', isEqualTo: product.productID)
          .get();

      if (query.docs.isNotEmpty) {
        // If the product is in the cart, remove it
        final cartItem = query.docs.first;
        await cartCollection.doc(cartItem.id).delete();
      }
    } catch (e) {
      print('Error removing from cart: $e');
    }
  }

  Future<void> clearCart() async {
    try {
      CollectionReference cartCollection =
          usersCollection.doc(userUid).collection('Cart');

      QuerySnapshot query = await cartCollection.get();

      // Delete all documents in the cart subcollection
      for (var doc in query.docs) {
        doc.reference.delete();
      }
    } catch (e) {
      print('Error clearing the cart: $e');
    }
  }

  Future<List<Products>> fetchProductsByCartItems(
      List<ShoppingCart> cartItems) async {
    try {
      final List<Products> products = [];

      for (var cartItem in cartItems) {
        final QuerySnapshot querySnapshot = await productsCollection
            .where('productID', isEqualTo: cartItem.productID)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          final doc = querySnapshot.docs.first;
          final data = doc.data() as Map<String, dynamic>;
          final product = Products(
            id: data['id'],
            name: data['name'],
            category: data['category'],
            description: data['description'],
            imageUrl: data['image_Url'],
            quantity: data['quantity'],
            price: data['price'],
            productID: data['productID'],
          );

          products.add(product);
        }
      }

      return products;
    } on FirebaseException catch (e) {
      print('Failed to fetch products: $e');
      return [];
    } catch (e) {
      print('Failed to fetch products: $e');
      return [];
    }
  }
}
