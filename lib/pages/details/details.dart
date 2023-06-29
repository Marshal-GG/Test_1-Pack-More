import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../models/product_model.dart';
import '../../../core/firebase_services.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage({Key? key}) : super(key: key);
  @override
  State createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late Future<String> _imageFuture;
  double averageRating = 2.5;
  bool isFavorite = false;
  late Products product;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    product = ModalRoute.of(context)!.settings.arguments as Products;
    fetchImageUrl();
  }

  void fetchImageUrl() {
    final FirebaseService firebaseService = FirebaseService();
    _imageFuture = firebaseService.getDownloadUrl(product.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Product Details'),
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildImage(product),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '${product.name} - This is for the Example',
                    // textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 30,
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '₹${product.price}',
                    style: TextStyle(
                      color: colorScheme.error,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      RatingBar.builder(
                        ignoreGestures: true,
                        initialRating: averageRating,
                        minRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 20.0,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '(4.5k) Reviews',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : null,
                        ),
                        onPressed: () {
                          setState(() {
                            isFavorite =
                                !isFavorite; // Toggle the favorite status
                          });
                        },
                      ),
                    ],
                  ),
                  Text(
                    '''${product.description} Amidst the vibrant hues of the setting sun, a gentle breeze caressed the fields of golden wheat. Birds chirped merrily, their songs echoing through the tranquil countryside. A lone figure, clad in a flowing cloak, wandered aimlessly along the meandering path, lost in deep contemplation.

As twilight descended, a blanket of stars adorned the velvet sky, twinkling with secrets untold. The moon, radiant and full, cast its soft glow upon the world below. Whispers of forgotten tales danced upon the night air, carrying ancient wisdom to those willing to listen.

In a distant village, laughter erupted from a cozy tavern, where friends gathered to share stories and toast to life's blessings. The aroma of freshly baked bread mingled with the tantalizing scent of simmering spices, enticing passersby with promises of warmth and nourishment.''',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 16,
                      color: colorScheme.outline,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: colorScheme.surface,
        elevation: 0,
        clipBehavior: Clip.none,
        child: Container(
          height: 56,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle buy button click
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 4,
                      backgroundColor: colorScheme.onPrimaryContainer,
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Buy Now',
                      style: TextStyle(
                        color: colorScheme.primaryContainer,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle add to cart button click
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 4,
                      backgroundColor: colorScheme.primaryContainer,
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Add to Cart',
                      style: TextStyle(
                        color: colorScheme.onPrimaryContainer,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder<String> buildImage(Products product) {
    final FirebaseService firebaseService = FirebaseService();
    _imageFuture = firebaseService.getDownloadUrl(product.imageUrl);
    return FutureBuilder<String>(
      future: _imageFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return AspectRatio(
              aspectRatio: 1,
              child: GestureDetector(
                // fix it later

                // onScaleUpdate: (ScaleUpdateDetails details) {
                //   setState(() {
                //     scaleFactor = details.scale.clamp(1.0, 5.0);
                //   });
                // },
                child: Hero(
                  tag: product.name,
                  child: Semantics(
                    label: product.name,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black.withOpacity(0.5),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(snapshot.data!),
                          fit: BoxFit.contain,
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
          child: Center(
            child: snapshot.connectionState == ConnectionState.waiting
                ? CircularProgressIndicator()
                : Text('No image available'),
          ),
        );
      },
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


