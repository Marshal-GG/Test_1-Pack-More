import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../core/models/product_model.dart';
import '../../core/firebase/services/firebase_services.dart';

class ProductDetailsPage extends StatefulWidget {
  ProductDetailsPage({Key? key}) : super(key: key);
  @override
  State createState() => _DetailsPageState();
}

class _DetailsPageState extends State<ProductDetailsPage> {
  final FirebaseService firebaseService = FirebaseService();
  late Products product;
  double averageRating = 2.5;
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    product = ModalRoute.of(context)!.settings.arguments as Products;
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Product Details'),
      ),
      body: _buildBodyContents(colorScheme),
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: [
        Container(
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
                  child: FilledButton(
                    onPressed: () {
                      // Handle add to cart button click
                    },
                    style: FilledButton.styleFrom(
                      elevation: 4,
                      backgroundColor: colorScheme.primaryContainer,
                      foregroundColor: colorScheme.onPrimaryContainer,
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
      ],
    );
  }

  SingleChildScrollView _buildBodyContents(ColorScheme colorScheme) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Hero(
            tag: product.name,
            child: AspectRatio(
              aspectRatio: 1,
              child: CachedNetworkImage(
                imageUrl: product.imageUrl!,
                fit: BoxFit.contain,
              ),
            ),
          ),
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
    );
  }
}
