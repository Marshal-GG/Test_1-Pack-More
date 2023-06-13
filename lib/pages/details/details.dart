import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import '../../../core/firebase_services.dart';

class DetailsPage extends StatefulWidget {
  // final Products product;

  // DetailsPage({required this.product});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late Future<String> _imageFuture;
  late Products product;
  double scaleFactor = 1.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Retrieve product from route arguments
    product = ModalRoute.of(context)!.settings.arguments as Products;
  }

  @override
  void initState() {
    super.initState();
    final FirebaseService firebaseService = FirebaseService();
    _imageFuture = firebaseService.getDownloadUrl(product.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Product Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FutureBuilder<String>(
              future: _imageFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: 400,
                      child: Hero(
                        tag: product.name,
                        child: GestureDetector(
                          onScaleUpdate: (ScaleUpdateDetails details) {
                            setState(() {
                              scaleFactor = details.scale.clamp(1.0, 5.0);
                            });
                          },
                          child: Container(
                            color: Colors.black.withOpacity(0.5),
                            child: Center(
                              child: Transform.scale(
                                scale: scaleFactor,
                                child: Semantics(
                                  label: product.name,
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot.data!,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Icon(Icons.error);
                  }
                }
                return SizedBox(
                  height: 300,
                  child: Center(
                    child: snapshot.connectionState == ConnectionState.waiting
                        ? CircularProgressIndicator()
                        : Text('No image available'),
                  ),
                );
              },
            ),
            // Rest of the content
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Price: ₹ ${product.price}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    product.description,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle buy button click
                    },
                    child: Text('Buy Now'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle add to cart button click
                    },
                    child: Text('Add to Cart'),
                  ),
                ],
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