import 'package:flutter/material.dart';
import '../../core/firebase/firebase_services.dart';
import '../../core/models/product_model.dart';

class PictureTest2 extends StatefulWidget {
  PictureTest2({super.key});

  @override
  State<PictureTest2> createState() => _PictureTest2State();
}

class _PictureTest2State extends State<PictureTest2> {
  FirebaseService firebaseService = FirebaseService();
  List<Products> products = [];
  int page = 1;
  ScrollController scrollController = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchProducts();
    scrollController.addListener(scrollListener); // Add scroll listener
  }

  void fetchProducts() async {
    if (isLoading) {
      return; // Return early if a fetch operation is already in progress
    }

    setState(() {
      isLoading = true;
    });

    List<Products> fetchedProducts =
        await firebaseService.fetchProductsByPages(page);

    // Fetch the image URL for each product
    for (var product in fetchedProducts) {
      try {
        String imageUrl =
            await firebaseService.getDownloadUrl(product.imageUrl!);
        product.setImageUrl(imageUrl);
      } catch (e) {
        print('Failed to fetch image URL: $e');
        product.setImageUrl('');
      }
    }

    setState(() {
      products.addAll(fetchedProducts); // Add fetched products to the list
      isLoading = false;
      page++;
    });
  }

  void scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      // Reached the end of the scrollable content
      fetchProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: scrollController,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.7),
      itemCount: products.length + 1,
      itemBuilder: (context, index) {
        if (index < products.length) {
          // Render your product card widget
          return ProductCard(products[index]);
        } else {
          // Reached the end of the list, show a loading indicator
          if (isLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return SizedBox.shrink(); // Return an empty widget if not loading
          }
        }
      },
    );
  }
}

class ProductCard extends StatelessWidget {
  final Products product;

  ProductCard(this.product);

  @override
  Widget build(BuildContext context) {
    return Card(
      // Customize the card appearance as per your needs
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            AspectRatio(
                aspectRatio: 1, child: Image.network(product.imageUrl!)),
            Text(product.name),
            Text(product.price.toString()),
            // Add more details or buttons as needed
          ],
        ),
      ),
    );
  }
}
