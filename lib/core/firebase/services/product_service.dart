import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_services.dart';
import '../../models/product_model.dart';

class ProductsService {
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');
  Future<List<Products>> fetchProductImageUrls(
      List<Products> products, FirebaseService firebaseService) async {
    List<Products> updatedProducts = [];
    for (var product in products) {
      if (product.imageUrl.startsWith('gs://')) {
        String? imageUrl =
            await firebaseService.getDownloadUrl(product.imageUrl);
        Products updatedProduct = product.copyWith(imageUrl: imageUrl);

        DocumentReference docRef = productsCollection.doc(product.productID);
        await docRef.update({'image_Url': imageUrl});
        updatedProducts.add(updatedProduct);
      } else {
        updatedProducts.add(product);
      }
    }
    return updatedProducts;
  }

  Future<Products?> fetchProductByProductID(String productID) async {
    try {
      final QuerySnapshot querySnapshot = await productsCollection
          .where('productID', isEqualTo: productID)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;
        final data = doc.data() as Map<String, dynamic>;
        return Products(
          id: data['id'],
          name: data['name'],
          category: data['category'],
          description: data['description'],
          imageUrl: data['image_url'],
          quantity: data['quantity'],
          price: data['price'],
          productID: data['productID'],
        );
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      print('Failed to fetch product: $e');
      return null;
    } catch (e) {
      print('Failed to fetch product: $e');
      return null;
    }
  }
}
