// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import '../../core/firebase/services/firebase_services.dart';
// import '../../core/models/product_model.dart';

// class PictureTest2 extends StatefulWidget {
//   PictureTest2({super.key});

//   @override
//   State<PictureTest2> createState() => _PictureTest2State();
// }

// class _PictureTest2State extends State<PictureTest2> {
//   FirebaseService firebaseService = FirebaseService();
//   List<Products> products = [];
//   int page = 1;
//   ScrollController scrollController = ScrollController();
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchProducts();
//     scrollController.addListener(scrollListener); // Add scroll listener
//   }

//   Future<void> fetchProducts() async {
//     List<Products> fetchedProducts =
//         await firebaseService.fetchProductsByPages(page);

//     setState(() {
//       products.addAll(fetchedProducts); // Add fetched products to the list
//       isLoading = false;
//       page++;
//     });

//     await fetchProductImageUrls(fetchedProducts);
//   }

//   Future<void> fetchProductImageUrls(List<Products> products) async {
//     for (var product in products) {
//       if (product.imageUrl != null) {
//         String? imageUrl =
//             await firebaseService.getDownloadUrl(product.imageUrl!);
//         setState(() {
//           // product.setImageUrl(imageUrl);
//         });
//       }
//     }
//   }

//   void scrollListener() {
//     if (scrollController.offset >= scrollController.position.maxScrollExtent &&
//         !scrollController.position.outOfRange) {
//       // Reached the end of the scrollable content
//       fetchProducts();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       // Show a loading indicator or placeholder while fetching products
//       return Center(child: CircularProgressIndicator());
//     }
//     return Scaffold(
//       appBar: AppBar(),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: GridView.builder(
//           controller: scrollController,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             mainAxisSpacing: 3,
//             crossAxisSpacing: 3,
//             childAspectRatio: MediaQuery.of(context).size.width /
//                 (MediaQuery.of(context).size.height / 1.45),
//           ),
//           itemCount: products.length + 1,
//           itemBuilder: (context, index) {
//             if (index < products.length) {
//               // Render your product card widget
//               return ProductCard(products[index]);
//             }
//             return null;
//           },
//         ),
//       ),
//     );
//   }
// }

// class ProductCard extends StatelessWidget {
//   final Products product;

//   ProductCard(this.product);

//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;
//     return GestureDetector(
//       onTap: () {
//         Navigator.pushNamed(
//           context,
//           '/product-details-page',
//           arguments: product,
//         );
//       },
//       child: Card(
//         elevation: 2,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(height: 8),
//               buildImage(),
//               SizedBox(height: 8),
//               Text(
//                 product.name,
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: colorScheme.tertiary,
//                 ),
//               ),
//               SizedBox(height: 4),
//               Text(
//                 '₹ ${product.price}',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: colorScheme.error,
//                 ),
//               ),
//               SizedBox(height: 8),
//               // Add more details or buttons as needed
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   AspectRatio buildImage() {
//     return AspectRatio(
//       aspectRatio: 1,
//       child: Hero(
//         tag: product.name,
//         child: CachedNetworkImage(
//           imageUrl: product.imageUrl!,
//           fit: BoxFit.contain,
//           errorWidget: (context, url, error) =>
//               Center(child: CircularProgressIndicator.adaptive()),
//         ),
//       ),
//     );
//   }
// }


class ShippingAddress {
  String address;
  String city;
  String state;
  String zipcode;

  ShippingAddress({
    required this.address,
    required this.city,
    required this.state,
    required this.zipcode,
  });

  Map<String, Object> toDocument() {
    final Map<String, Object> shippingAddress = {
      'address': address,
      'city': city,
      'state': state,
      'zipcode': zipcode,
    };

    return {
      'shippingAddress': shippingAddress,
      'name': 'John Doe',
      'email': 'johndoe@example.com',
      'contactNumber': '1234567890',
      'products': [
        {
          'id': '1',
          'name': 'Product 1',
          'category': 'Category A',
          'description': 'Description for Product 1',
          'imageUrl': 'https://example.com/product1.jpg',
          'quantity': 2,
          'price': 25.0,
          'productID': 'P12345',
        },
        {
          'id': '2',
          'name': 'Product 2',
          'category': 'Category B',
          'description': 'Description for Product 2',
          'imageUrl': 'https://example.com/product2.jpg',
          'quantity': 1,
          'price': 30.0,
          'productID': 'P67890',
        },
      ],
      'coupon': 'DISCOUNTCODE',
      'couponDiscount': 5.0,
      'subtotal': 85.0,
      'deliveryFee': 10.0,
      'total': 90.0,
    };
  }
}

void main() {
  final shippingAddress = ShippingAddress(
    address: '123 Main St',
    city: 'Sample City',
    state: 'Sample State',
    zipcode: '12345',
  );

  final mockData = shippingAddress.toDocument();
  print(mockData);
}