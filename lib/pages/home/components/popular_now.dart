import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:test_1/core/widgets/dot_divider.dart';
import '../../../core/models/product_model.dart';
import '../bloc/home_page_bloc.dart';

class PopularCategoryWidget extends StatefulWidget {
  const PopularCategoryWidget({
    super.key,
    required this.colorScheme,
    required this.state,
  });

  final ColorScheme colorScheme;
  final HomePageState state;

  @override
  State<PopularCategoryWidget> createState() => _PopularCategoryWidgetState();
}

class _PopularCategoryWidgetState extends State<PopularCategoryWidget> {
  double averageRating = 2.5;

  @override
  Widget build(BuildContext context) {
    final state = widget.state as HomePageInitial;
    final products = state.products;

    return Expanded(
      flex: 0,
      child: Column(
        children: [
          buildHeader(),
          buildCards(products, context),
        ],
      ),
    );
  }

  SingleChildScrollView buildCards(
    List<Products> products,
    BuildContext context,
  ) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(
        decelerationRate: ScrollDecelerationRate.fast,
      ),
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(
            decelerationRate: ScrollDecelerationRate.fast,
          ),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: products.map((product) {
              return GestureDetector(
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
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    elevation: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        buildImage(product),
                        SizedBox(height: 8),
                        Text(
                          product.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: widget.colorScheme.onSurfaceVariant,
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
                              itemSize: 16.0,
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                            DotDivider(),
                            Text(
                              '4.5k',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                        // Text(
                        //   product.category,
                        //   style: TextStyle(
                        //     fontSize: 10,
                        //     fontWeight: FontWeight.normal,
                        //     color: widget.colorScheme.tertiary,
                        //   ),
                        // ),
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
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  SingleChildRenderObjectWidget buildImage(Products product) {
    return SizedBox(
      height: 140,
      width: 180,
      child: Hero(
        tag: product.name,
        child: Semantics(
          label: product.name,
          child: CachedNetworkImage(
            imageUrl: product.imageUrl!,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) =>
                Center(child: CircularProgressIndicator.adaptive()),
          ),
        ),
      ),
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
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: widget.colorScheme.onBackground,
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/view-all-products-page',
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
