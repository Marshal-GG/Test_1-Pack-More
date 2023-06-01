import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/product_model.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Firebase authentication methods
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print('Failed to sign in: $e');
      return null;
    } catch (e) {
      print('Failed to sign in: $e');
      return null;
    }
  }

  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print('Failed to create user: $e');
      return null;
    } catch (e) {
      print('Failed to create user: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Firestore methods
  Future<DocumentSnapshot<Map<String, dynamic>>?> getUserProfile(
      String uid) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('users').doc(uid).get();
      return snapshot;
    } on FirebaseException catch (e) {
      print('Failed to get user profile: $e');
      return null;
    } catch (e) {
      print('Failed to get user profile: $e');
      return null;
    }
  }

  Future<void> updateUserProfile(String uid, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('Users').doc(uid).update(data);
    } on FirebaseException catch (e) {
      print('Failed to update user profile: $e');
    } catch (e) {
      print('Failed to update user profile: $e');
    }
  }

  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');

  Future<List<Products>> fetchProducts() async {
    QuerySnapshot querySnapshot = await productsCollection.get();
    List<Products> products = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Products(
        id: data['id'],
        name: data['name'],
        category: data['category'],
        description: data['description'],
        imageUrl: data['image_url'],
        image: data['image'],
        quantity: data['quantity'],
        price: data['price'],
      );
    }).toList();
    return products;
  }

  // Firebase Storage methods
  Future<String?> uploadImage(File imageFile) async {
    try {
      String imageName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageRef = _storage.ref().child('images/$imageName.jpg');
      UploadTask uploadTask = storageRef.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      String downloadURL = await snapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Failed to upload image: $e');
      return null;
    }
  }

  Future<List<String>> fetchImageUrls() async {
    try {
      ListResult listResult = await _storage.ref().child('assests').listAll();
      List<Reference> imageRefs = listResult.items;
      List<String> imageUrls = [];
      for (Reference ref in imageRefs) {
        String downloadURL = await ref.getDownloadURL();
        imageUrls.add(downloadURL);
      }
      return imageUrls;
    } catch (e) {
      print('Failed to fetch image URLs: $e');
      return [];
    }
  }

  Future<String> getDownloadUrl(String storageLocation) async {
  try {
    Reference ref = FirebaseStorage.instance.refFromURL(storageLocation);
    String downloadURL = await ref.getDownloadURL();
    return downloadURL;
  } catch (e) {
    print('Failed to get download URL: $e');
    return '';
  }
}

  // Future<String> getDownloadUrl(String storageLocation) async {
  //   try {
  //     String convertedUrl = storageLocation.replaceFirst(
  //         'gs://', 'https://storage.googleapis.com/');
  //     String downloadURL = await FirebaseStorage.instance
  //         .refFromURL(convertedUrl)
  //         .getDownloadURL();
  //     return downloadURL;
  //   } catch (e) {
  //     print('Failed to get download URL: $e');
  //     return '';
  //   }
  // }

  // Future<void> addProduct(Products product) async {
  //   await productsCollection.add({
  //     'id': product.id,
  //     'name': product.name,
  //     'category': product.category,
  //     'description': product.description,
  //     'image': product.image,
  //     'quantity': product.quantity,
  //     'price': product.price,
  //   });
  // }

  Future<void> addProduct(Products product) async {
    try {
      String? imageUrl = await uploadImage(File(product.image));
      if (imageUrl != null) {
        await productsCollection.add({
          'id': product.id,
          'name': product.name,
          'category': product.category,
          'description': product.description,
          'image': imageUrl,
          'quantity': product.quantity,
          'price': product.price,
        });
      }
    } catch (e) {
      print('Failed to add product: $e');
    }
  }
}
