import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import '../../../core/firebase_services.dart';

class DetailsPage extends StatelessWidget {
  final Products product;
  FirebaseService firebaseService = FirebaseService();
  DetailsPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Product image
            SizedBox(
              height: 140,
              width: 180,
              child: Hero(
                tag: product.name,
                child: FutureBuilder<String>(
                  future: firebaseService.getDownloadUrl(product.imageUrl),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Image.network(
                        snapshot.data!,
                        semanticLabel: product.name,
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ),

            // Product name
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                product.name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Product price
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Price: ₹ ${product.price}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Product description
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                product.description,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),

            // Buy button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Handle buy button click
                },
                child: Text('Buy Now'),
              ),
            ),

            // Add to cart button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Handle add to cart button click
                },
                child: Text('Add to Cart'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class DetailsPage extends StatefulWidget {
  
//   const DetailsPage({super.key, required Products product});

//   @override
//   State<DetailsPage> createState() => _DetailsPageState();
// }

// class _DetailsPageState extends State<DetailsPage> {
//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;
//     // Products e = ModalRoute.of(context)!.settings.arguments as Products;
//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         children: [
//           Expanded(
//             flex: 2,
//             child: Container(
//               decoration: BoxDecoration(
//                 color: colorScheme.onSurface,
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(60),
//                   topRight: Radius.circular(60),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                       color: colorScheme.shadow,
//                       offset: Offset(-2, -3),
//                       blurRadius: 12)
//                 ],
//               ),
//               child: Stack(
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       SizedBox(height: 80),
//                       Spacer(flex: 8),
//                       Padding(
//                         padding: EdgeInsets.symmetric(
//                           vertical: 5,
//                           horizontal: 20,
//                         ),
//                       )
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }