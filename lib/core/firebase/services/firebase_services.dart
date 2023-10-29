import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../models/product_model.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');
  final _googleSignIn = GoogleSignIn();
  User? currentUser;
  String? userName;
  String? userEmail;
  SharedPreferences? _prefs;
  int _perPage = 10; // Number of products to fetch per page
  String? lastDocumentName; // Track the last document fetched

  Future<void> initializeSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveUserDataToPrefs(String name, String email) async {
    await _prefs?.setString('name', name);
    await _prefs?.setString('email', email);
  }

  Future<String?> getNameFromPrefs() async {
    return _prefs?.getString('name');
  }

  Future<String?> getEmailFromPrefs() async {
    return _prefs?.getString('email');
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        await _auth.signInWithCredential(authCredential);
        currentUser = _auth.currentUser;
        await _firestore.collection('Users').doc(currentUser?.uid).set(
          {
            "Name": currentUser?.displayName,
            "Email": currentUser?.email,
          },
          SetOptions(merge: true),
        );
        await _firestore
            .collection('Users')
            .doc(currentUser?.uid)
            .collection("Details")
            .doc("Basic Info")
            .set(
          {
            "GName": currentUser?.displayName,
            "Email": currentUser?.email,
            "Uid": currentUser?.uid,
            "Photo URL": currentUser?.photoURL,
          },
          SetOptions(merge: true),
        );
        await _firestore
            .collection('Users')
            .doc(currentUser?.uid)
            .collection('Details')
            .doc('Provided Info')
            .set(
          {
            "GNumber": currentUser?.phoneNumber,
          },
          SetOptions(merge: true),
        );
        await _firestore
            .collection('Users')
            .doc(currentUser?.uid)
            .collection('Details')
            .doc('Address')
            .set(
          {
            "Address": "",
            "City": "",
            "Zipcode": "",
          },
          SetOptions(merge: true),
        );
        await saveUserDataToPrefs(
            currentUser?.displayName ?? '', currentUser?.email ?? '');
      }
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

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

  Future<List<Products>> fetchProductsByPages(int page) async {
    try {
      Query query = productsCollection.orderBy('name').limit(_perPage);

      if (page > 1) {
        query = query.startAfter([lastDocumentName ?? '']);
      }

      final QuerySnapshot querySnapshot = await query.get();

      final List<Products> products = querySnapshot.docs.map((doc) {
        final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
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
      }).toList();

      // Update the lastDocumentName for pagination
      if (products.isNotEmpty) {
        final lastProduct = products.last;
        lastDocumentName = lastProduct.name; // Assuming 'name' is unique
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

  Future<List<Products>> fetchProducts() async {
    try {
      final QuerySnapshot querySnapshot = await productsCollection.get();
      return querySnapshot.docs.map((doc) {
        final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Products(
          id: data['id'],
          name: data['name'],
          category: data['category'],
          description: data['description'],
          imageUrl: data['image_Url'],
          quantity: data['quantity'],
          price: data['price'],
          productID: data['productID'],
        );
      }).toList();
    } on FirebaseException catch (e) {
      print('Failed to fetch products: $e');
      return [];
    } catch (e) {
      print('Failed to fetch products: $e');
      return [];
    }
  }

  Future<List<Products>> fetchProductsByCategory(
      String selectedCategoryName) async {
    try {
      final QuerySnapshot querySnapshot = await productsCollection
          .where('category', isEqualTo: selectedCategoryName)
          .get();

      return querySnapshot.docs.map((doc) {
        final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Products(
          id: data['id'],
          name: data['name'],
          category: data['category'],
          description: data['description'],
          imageUrl: data['image_Url'],
          quantity: data['quantity'],
          price: data['price'],
          productID: data['productID'],
        );
      }).toList();
    } on FirebaseException catch (e) {
      print('Failed to fetch products: $e');
      return [];
    } catch (e) {
      print('Failed to fetch products: $e');
      return [];
    }
  }

  // Firebase Storage methods
  Future<String?> uploadImage(File imageFile) async {
    try {
      final String imageName = DateTime.now().millisecondsSinceEpoch.toString();
      final Reference storageRef =
          _storage.ref().child('images/$imageName.jpg');
      final UploadTask uploadTask = storageRef.putFile(imageFile);
      final TaskSnapshot snapshot = await uploadTask;
      final String downloadURL = await snapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Failed to upload image: $e');
      return null;
    }
  }

  Future<String> getDownloadUrl(String storageLocation) async {
    try {
      final Reference ref =
          FirebaseStorage.instance.refFromURL(storageLocation);
      final String downloadURL = await ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Failed to get download URL: $e');
      return '';
    }
  }

  Future<void> addProduct(Products product) async {
    try {
      final String? imageUrl = await uploadImage(File(product.imageUrl));
      if (imageUrl != null) {
        await productsCollection.add({
          'id': product.id,
          'name': product.name,
          'category': product.category,
          'description': product.description,
          'image_url': imageUrl,
          'quantity': product.quantity,
          'price': product.price,
        });
      }
    } catch (e) {
      print('Failed to add product: $e');
    }
  }
}
