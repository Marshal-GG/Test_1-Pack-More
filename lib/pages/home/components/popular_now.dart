import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/getx/category_controller_getx.dart';
import '../../../core/firebase/firebase_services.dart';
import '../../../core/models/product_model.dart';

class PopularCategoryWidget extends StatefulWidget {
  const PopularCategoryWidget({
    super.key,
    required this.colorScheme,
  });

  final ColorScheme colorScheme;

  @override
  State<PopularCategoryWidget> createState() => _PopularCategoryWidgetState();
}

class _PopularCategoryWidgetState extends State<PopularCategoryWidget> {
  FirebaseService firebaseService = FirebaseService();
  List<Products> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  void fetchProducts() async {
    List<Products> fetchedProducts = await firebaseService.fetchProducts();

    await fetchProductImageUrls(fetchedProducts);

    setState(() {
      products.addAll(fetchedProducts);
    });
  }

  Future<void> fetchProductImageUrls(List<Products> products) async {
    List<Future<String?>> imageFetchingFutures = [];

    for (var product in products) {
      if (product.imageUrl != null) {
        imageFetchingFutures
            .add(firebaseService.getDownloadUrl(product.imageUrl!));
      }
    }

    List<String?> imageUrls = await Future.wait(imageFetchingFutures);

    for (int i = 0; i < products.length; i++) {
      if (products[i].imageUrl != null && i < imageUrls.length) {
        products[i].setImageUrl(imageUrls[i] ?? '');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 0,
      child: Column(
        children: [
          buildHeader(),
          buildCards(),
        ],
      ),
    );
  }

  SingleChildScrollView buildCards() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(
        decelerationRate: ScrollDecelerationRate.fast,
      ),
      scrollDirection: Axis.vertical,
      child: GetBuilder<CategoryControllerGetx>(
        builder: (carouselController) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(
                decelerationRate: ScrollDecelerationRate.fast,
              ),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: products.map((product) {
                  int id = carouselController.categoryModelGetx.i + 1;
                  return (product.id == id)
                      ? GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/product-details-page',
                              arguments: product,
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              elevation: 2,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 8),
                                    buildImage(product),
                                    SizedBox(height: 8),
                                    Text(
                                      product.name,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            widget.colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                    Text(
                                      product.category,
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal,
                                        color: widget.colorScheme.tertiary,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      '₹ ${product.price}',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: widget.colorScheme.error,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      : SizedBox.shrink();
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }

  SizedBox buildImage(Products product) {
    return SizedBox(
      height: 140,
      width: 180,
      child: Hero(
          tag: product.name,
          child: Semantics(
            label: product.name,
            child: CachedNetworkImage(
              imageUrl: product.imageUrl!,
              fit: BoxFit.contain,
            ),
          )),
    );
  }

  Padding buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: Row(
        children: [
          Text(
            'Popular Now!',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              color: widget.colorScheme.onBackground,
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/picture2-test-page',
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              elevation: 2,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 14,
                    color: widget.colorScheme.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
