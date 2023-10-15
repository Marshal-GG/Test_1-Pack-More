import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:test_1/core/models/seller_product_model.dart';

import '../firebase_services.dart';

class SellerProductService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('Products Test');
  CollectionReference imagesCollection =
      FirebaseFirestore.instance.collection('ProductImages Test');
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('Users');

  // Get the Products Data
  Future<List<SellerProducts>> getUserProducts(String userUid) async {
    List<SellerProducts> products = [];

    DocumentSnapshot userSnapshot = await usersCollection.doc(userUid).get();
    List<String> productIds = List.from(userSnapshot['productIds']);

    for (String productId in productIds) {
      DocumentSnapshot productSnapshot =
          await productsCollection.doc(productId).get();

      SellerProducts product = SellerProducts(
        id: productId,
        name: productSnapshot['name'],
        price: productSnapshot['price'],
        description: productSnapshot['description'],
        quantity: productSnapshot['quantity'],
        category: productSnapshot['category'],
        status: productSnapshot['status'],
        imageUrls: [],
      );
      products.add(product);
    }

    // for (int i = 0; i < products.length; i++) {
    //   List<String> imageUrls = await getProductImageUrls(products[i].id);
    //   products[i].imageUrls = imageUrls.cast<String>();
    // }

    return products;
  }

  Future<List<SellerProducts>> fetchProductImageUrls(
      List<SellerProducts> products, FirebaseService firebaseService) async {
    List<SellerProducts> updatedProducts = List.of(products);
    for (int i = 0; i < products.length; i++) {
      List<String> imageUrls = await getProductImageUrls(products[i].id);
      updatedProducts[i] =
          updatedProducts[i].copyWith(imageUrls: imageUrls.cast<String>());
      // products[i].imageUrls = imageUrls.cast<String>();
    }
    return updatedProducts;
  }

  // Get the Products Images
  Future<List<String>> getProductImageUrls(String productId) async {
    List<String> imageUrls = [];

    QuerySnapshot imagesSnapshot =
        await imagesCollection.where('productId', isEqualTo: productId).get();

    for (QueryDocumentSnapshot imageDoc in imagesSnapshot.docs) {
      String imageUrl = imageDoc['imageUrl'];
      if (imageUrl.startsWith('gs://')) {
        // Convert Firebase Storage Path URL to HTTP URL
        Reference storageReference =
            FirebaseStorage.instance.refFromURL(imageUrl);
        imageUrl = await storageReference.getDownloadURL();
      }
      imageUrls.add(imageUrl);
    }

    return imageUrls;
  }

  // Delete the Product
  Future<void> deleteProduct(SellerProducts product) async {
    try {
      // Delete the product document
      await productsCollection.doc(product.id).delete();

      // Delete associated images
      QuerySnapshot imagesSnapshot = await imagesCollection
          .where('productId', isEqualTo: product.id)
          .get();

      for (QueryDocumentSnapshot imageDoc in imagesSnapshot.docs) {
        String imageUrl = imageDoc['imageUrl'];

        // Create a reference to the image in Firebase Storage
        Reference storageReference = _storage.refFromURL(imageUrl);

        // Delete image from storage
        await storageReference.delete();

        // Delete the image document
        await imageDoc.reference.delete();
      }

      // Remove the product ID from the user's document
      String userUid = FirebaseAuth.instance.currentUser!.uid;
      DocumentReference userDocRef = usersCollection.doc(userUid);
      await userDocRef.update({
        'productIds': FieldValue.arrayRemove([product.id]),
      });
    } catch (e) {
      throw Exception('Failed to delete product: $e');
    }
  }
}
