import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_1/core/widgets/custom_drawer.dart';

import '../../../core/firebase/firebase_services.dart';

class Products {
  final String id;
  final String name;
  final double price;
  final String description;
  final String catergory;
  final String status;
  final int quantity;
  List<String> imageUrls;

  Products({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.catergory,
    required this.status,
    required this.quantity,
    required this.imageUrls,
  });
}

class SellerProductsPage extends StatefulWidget {
  SellerProductsPage({super.key});

  @override
  State<SellerProductsPage> createState() => _UserProductsPageState();
}

class _UserProductsPageState extends State<SellerProductsPage> {
  String userUid = FirebaseAuth.instance.currentUser!.uid;
  FirebaseService firebaseService = FirebaseService();
  late List<Products> products;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getUserProducts();
  }

  Future<void> _getUserProducts() async {
    products = [];

    DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('Users').doc(userUid).get();

    List<String> productIds = List.from(userSnapshot['productIds']);

    for (String productId in productIds) {
      DocumentSnapshot productSnapshot = await FirebaseFirestore.instance
          .collection('Products Test')
          .doc(productId)
          .get();

      Products product = Products(
        id: productId,
        name: productSnapshot['name'],
        price: productSnapshot['price'],
        description: productSnapshot['description'],
        quantity: productSnapshot['quantity'],
        catergory: productSnapshot['category'],
        status: productSnapshot['status'],
        imageUrls: [],
      );
      products.add(product);
    }
    // Trigger a rebuild after fetching products
    setState(() {
      isLoading = false;
    });

    for (int i = 0; i < products.length; i++) {
      List<String> imageUrls = await _getProductImageUrls(products[i].id);
      products[i].imageUrls = imageUrls.cast<String>();
      setState(() {});
    }
  }

  Future<List<String>> _getProductImageUrls(String productId) async {
    List<String> imageUrls = [];

    QuerySnapshot imagesSnapshot = await FirebaseFirestore.instance
        .collection('ProductImages Test')
        .where('productId', isEqualTo: productId)
        .get();

    for (QueryDocumentSnapshot imageDoc in imagesSnapshot.docs) {
      String imageUrl =
          await firebaseService.getDownloadUrl(imageDoc['imageUrl']);
      imageUrls.add(imageUrl);
    }
    return imageUrls;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: Text('Your Products')),
      drawer: CustomDrawerWidget(),
      body: _buildProductsList(colorScheme),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/add-product-page');
        },
      ),
    );
  }

  Widget _buildProductsList(ColorScheme colorScheme) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (products.isEmpty) {
      return Text('No Data Available');
    }
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        Products product = products[index];
        return ListTile(
          leading: product.imageUrls.isNotEmpty
              ? CircleAvatar(
                  radius: 24,
                  backgroundImage:
                      CachedNetworkImageProvider(product.imageUrls[0]),
                )
              : CircularProgressIndicator.adaptive(),
          title: Text(product.name),
          subtitle: Text(
            'Price: ₹ ${product.price}',
            style: TextStyle(color: colorScheme.onSurfaceVariant),
          ),
          trailing: Icon(Icons.keyboard_arrow_right, size: 24),
          onTap: () {
            Navigator.pushNamed(
              context,
              '/seller-product-details-page',
              arguments: product,
            );
          },
        );
      },
    );
  }
}
