import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import '../seller_products_page/seller_products_page.dart';

class SellerProductDetailsPage extends StatefulWidget {
  const SellerProductDetailsPage({super.key});

  @override
  State<SellerProductDetailsPage> createState() =>
      _SellerProductDetailsPageState();
}

class _SellerProductDetailsPageState extends State<SellerProductDetailsPage> {
  late Products product;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    product = ModalRoute.of(context)!.settings.arguments as Products;
    return Scaffold(
      appBar: AppBar(title: Text('Details')),
      body: _buidBodyContents(colorScheme),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit_outlined),
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/add-product-page',
            arguments: product,
          );
        },
      ),
    );
  }

  Padding _buidBodyContents(ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Card(
            color: Colors.black87,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      pauseAutoPlayOnTouch: true,
                      enlargeCenterPage: true,
                      pauseAutoPlayOnManualNavigate: true,
                      autoPlay: true,
                      // viewportFraction: 0.8,
                      autoPlayInterval: Duration(seconds: 4),
                      autoPlayCurve: Curves.easeInOut,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                    items: product.imageUrls.map((imageUrl) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              if (product.imageUrls.isNotEmpty)
                                CachedNetworkImage(
                                  imageUrl: imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              if (imageUrl.isEmpty)
                                Center(child: CircularProgressIndicator())
                            ],
                          );
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 4),
                  Card(
                    color: colorScheme.secondaryContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        child: product.imageUrls.isNotEmpty
                            ? DotsIndicator(
                                dotsCount: product.imageUrls.length,
                                position: _currentIndex,
                                decorator: DotsDecorator(
                                  activeColor: colorScheme.primary,
                                  color: colorScheme.onSurfaceVariant,
                                  activeSize: Size(10, 10),
                                  size: Size(8, 8),
                                  activeShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  spacing: EdgeInsets.all(4),
                                ),
                              )
                            : SizedBox.shrink(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            elevation: 3,
            child: Column(
              children: [
                ListTile(
                  // tileColor: colorScheme.secondaryContainer,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(64))),
                  title: Text('Name: ${product.name}'),
                ),
                ListTile(
                  // tileColor: colorScheme.secondaryContainer,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(64))),
                  title: Text('Category: ${product.catergory}'),
                ),
                ListTile(
                  // tileColor: colorScheme.secondaryContainer,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(64))),
                  title: Text('Price: ₹ ${product.price}'),
                ),
                ListTile(
                  // tileColor: colorScheme.secondaryContainer,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(64))),
                  title: Text('Quantity: ${product.quantity}'),
                ),
                ListTile(
                  // tileColor: colorScheme.secondaryContainer,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(64))),
                  title: Text('Description: ${product.description}'),
                ),
                ListTile(
                  // tileColor: colorScheme.secondaryContainer,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(64))),
                  title: Text('Unique ID: ${product.id}'),
                ),
              ],
            ),
          ),
          Divider(),
          Card(
            color: colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [Text('Status: ${product.status}')],
              ),
            ),
          )
        ],
      ),
    );
  }
}
