import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/controller/getx/category_controller_getx.dart';
import '../../core/firebase/firebase_services.dart';
import '../../core/models/product_model.dart';

class PictureTest extends StatefulWidget {
  const PictureTest({super.key});

  @override
  State<PictureTest> createState() => _PictureTestState();
}

class _PictureTestState extends State<PictureTest> {
  FirebaseService firebaseService = FirebaseService();
  List<Products> products = [];
  String imageUrl = '';
  bool isFavorite = false;
  int page = 1;

  @override
  void initState() {
    super.initState();
    fetchImageUrl(
        'gs://test-1-flutter.appspot.com/assets/images/fiction/f4.png');
    fetchProductsByPages();
  }

  // void fetchProducts() async {
  //   List<Products> fetchedProducts = await firebaseService.fetchProducts();

  //   setState(() {
  //     products = fetchedProducts;
  //   });
  // }

  void fetchProductsByPages() async {
    List<Products> fetchedProducts =
        await firebaseService.fetchProductsByPages(page);
    setState(() {
      products.addAll(fetchedProducts);
    });
    page++;
  }

  void loadNextPage() {
    fetchProductsByPages();
  }

  Future<void> fetchImageUrl(String imageUrl) async {
    try {
      String downloadUrl = await firebaseService.getDownloadUrl(imageUrl);
      setState(() {
        this.imageUrl = downloadUrl;
      });
    } catch (error) {
      print('Error: $error');
    }
  }

  void reloadImage() {
    setState(() {
      imageUrl = '';
    });
    fetchImageUrl(
        'gs://test-1-flutter.appspot.com/assets/images/fiction/f3.png');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text("data"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GetBuilder<CategoryControllerGetx>(
              builder: (carouselController) {
                return Column(
                  children: [
                    Row(
                      children: products.map<Widget>(
                        (product) {
                          int id = carouselController.categoryModelGetx.i + 1;
                          return (product.id == id)
                              ? GestureDetector(
                                  onTap: () {},
                                  child: Card(
                                    elevation: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Column(
                                          children: [
                                            // image render
                                            AspectRatio(
                                              aspectRatio: 1,
                                              child: imageUrl.isNotEmpty
                                                  ? CachedNetworkImage(
                                                      imageUrl: imageUrl)
                                                  : Center(
                                                      child:
                                                          CircularProgressIndicator()),
                                            ),
                                            // button
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: reloadImage,
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.deepPurple,
                                                    ),
                                                    child: Text('Reload'),
                                                  ),
                                                  Spacer(),
                                                  IconButton(
                                                    icon: Icon(
                                                      isFavorite
                                                          ? Icons.favorite
                                                          : Icons
                                                              .favorite_border,
                                                      color: isFavorite
                                                          ? Colors.red
                                                          : null,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        isFavorite =
                                                            !isFavorite;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox.shrink();
                        },
                      ).toList(),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
