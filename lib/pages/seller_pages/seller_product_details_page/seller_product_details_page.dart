import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/seller_product_model.dart';
import 'bloc/seller_product_details_page_bloc.dart';

class SellerProductDetailsPage extends StatefulWidget {
  @override
  State<SellerProductDetailsPage> createState() =>
      _SellerProductDetailsPageState();
}

class _SellerProductDetailsPageState extends State<SellerProductDetailsPage> {
  int currentIndex = 0;

  void _showDialog(BuildContext context, ColorScheme colorScheme, String msg) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          BlocProvider.of<SellerProductDetailsBloc>(context)
              .add(SellerProductDetailsPageCounterEvent());
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: AlertDialog(
              backgroundColor: colorScheme.background.withOpacity(0.8),
              title: Text('Success'),
              content: Text(msg),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    SellerProducts product =
        ModalRoute.of(context)!.settings.arguments as SellerProducts;
    return Scaffold(
      appBar: _buildAppBar(context, colorScheme, product),
      body: BlocBuilder<SellerProductDetailsBloc, SellerProductDetailsState>(
        builder: (context, state) {
          if (state is SellerProductDetailsPageLoaded) {
            return _buildBodyContents(colorScheme, product);
          } else if (state is ProductDeletedState) {
            _showDialog(context, colorScheme, 'Product deleted successfully');
            return Container();
          } else if (state is DeleteErrorState) {
            _showDialog(
              context,
              colorScheme,
              'An error occurred while deleting your product. Please try again later.',
            );
            return Container();
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  AppBar _buildAppBar(
    BuildContext context,
    ColorScheme colorScheme,
    SellerProducts product,
  ) {
    return AppBar(
      title: Text('Details'),
      actions: [
        PopupMenuButton(
          onSelected: (String choice) {
            switch (choice) {
              case 'Delete':
                BlocProvider.of<SellerProductDetailsBloc>(context)
                    .add(DeleteProductEvent(product: product));
                break;
              case 'Help & Feedback':
                Navigator.of(context).pushNamed('/help-feedback-page');
                break;
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(
                value: 'Delete',
                child: Text('Delete'),
              ),
              PopupMenuItem<String>(
                value: 'Help & Feedback',
                child: Text('Help & Feedback'),
              ),
            ];
          },
        )
      ],
    );
  }

  Padding _buildBodyContents(
    ColorScheme colorScheme,
    SellerProducts product,
  ) {
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
                          currentIndex = index;
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
                                position: currentIndex,
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
                  title: Text('Category: ${product.category}'),
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

// class SellerProductDetailsPage extends StatefulWidget {
//   @override
//   State<SellerProductDetailsPage> createState() =>
//       _SellerProductDetailsPageState();
// }

// class _SellerProductDetailsPageState extends State<SellerProductDetailsPage> {
//   late SellerProductDetailsBloc _detailsBloc;
//   late Products product;
//   int _currentIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     _detailsBloc = SellerProductDetailsBloc(SellerProductService());
//   }

//   @override
//   void dispose() {
//     _detailsBloc.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;
//     product = ModalRoute.of(context)!.settings.arguments as Products;
//     return BlocBuilder<SellerProductDetailsBloc, SellerProductDetailsState>(
//         builder: (context, state) {
//       if (state is ProductDeletedState) {
//         // Handle success, e.g., show a success message
//         Navigator.pop(context); // Go back to previous page
//       } else if (state is DeleteErrorState) {
//         // Handle delete error, e.g., show an error message
//       }
//       return Scaffold(
//         appBar: _buildAppBar(context, colorScheme),
//         body: _buildBodyContents(colorScheme),
//         floatingActionButton: FloatingActionButton(
//           child: Icon(Icons.edit_outlined),
//           onPressed: () {
//             _detailsBloc.add(DeleteProductEvent(product));
//           },
//         ),
//       );
//     });
//   }

//   Padding _buildBodyContents(ColorScheme colorScheme) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         children: [
//           Card(
//             color: Colors.black87,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   CarouselSlider(
//                     options: CarouselOptions(
//                       pauseAutoPlayOnTouch: true,
//                       enlargeCenterPage: true,
//                       pauseAutoPlayOnManualNavigate: true,
//                       autoPlay: true,
//                       // viewportFraction: 0.8,
//                       autoPlayInterval: Duration(seconds: 4),
//                       autoPlayCurve: Curves.easeInOut,
//                       onPageChanged: (index, reason) {
//                         setState(() {
//                           _currentIndex = index;
//                         });
//                       },
//                     ),
//                     items: product.imageUrls.map((imageUrl) {
//                       return Builder(
//                         builder: (BuildContext context) {
//                           return Stack(
//                             alignment: Alignment.center,
//                             children: [
//                               if (product.imageUrls.isNotEmpty)
//                                 CachedNetworkImage(
//                                   imageUrl: imageUrl,
//                                   fit: BoxFit.cover,
//                                 ),
//                               if (imageUrl.isEmpty)
//                                 Center(child: CircularProgressIndicator())
//                             ],
//                           );
//                         },
//                       );
//                     }).toList(),
//                   ),
//                   SizedBox(height: 4),
//                   Card(
//                     color: colorScheme.secondaryContainer,
//                     child: Padding(
//                       padding: const EdgeInsets.all(2.0),
//                       child: AnimatedContainer(
//                         duration: Duration(milliseconds: 300),
//                         child: product.imageUrls.isNotEmpty
//                             ? DotsIndicator(
//                                 dotsCount: product.imageUrls.length,
//                                 position: _currentIndex,
//                                 decorator: DotsDecorator(
//                                   activeColor: colorScheme.primary,
//                                   color: colorScheme.onSurfaceVariant,
//                                   activeSize: Size(10, 10),
//                                   size: Size(8, 8),
//                                   activeShape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(5),
//                                   ),
//                                   spacing: EdgeInsets.all(4),
//                                 ),
//                               )
//                             : SizedBox.shrink(),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Card(
//             elevation: 3,
//             child: Column(
//               children: [
//                 ListTile(
//                   // tileColor: colorScheme.secondaryContainer,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(64))),
//                   title: Text('Name: ${product.name}'),
//                 ),
//                 ListTile(
//                   // tileColor: colorScheme.secondaryContainer,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(64))),
//                   title: Text('Category: ${product.catergory}'),
//                 ),
//                 ListTile(
//                   // tileColor: colorScheme.secondaryContainer,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(64))),
//                   title: Text('Price: ₹ ${product.price}'),
//                 ),
//                 ListTile(
//                   // tileColor: colorScheme.secondaryContainer,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(64))),
//                   title: Text('Quantity: ${product.quantity}'),
//                 ),
//                 ListTile(
//                   // tileColor: colorScheme.secondaryContainer,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(64))),
//                   title: Text('Description: ${product.description}'),
//                 ),
//                 ListTile(
//                   // tileColor: colorScheme.secondaryContainer,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(64))),
//                   title: Text('Unique ID: ${product.id}'),
//                 ),
//               ],
//             ),
//           ),
//           Divider(),
//           Card(
//             color: colorScheme.primaryContainer,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [Text('Status: ${product.status}')],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   AppBar _buildAppBar(BuildContext context, ColorScheme colorScheme) {
//     return AppBar(
//       title: Text('Details'),
//       actions: [
//         PopupMenuButton(
//           onSelected: (String choice) {
//             switch (choice) {
//               case 'Delete':
//                 _showDeleteConfirmationDialog(context, colorScheme);
//                 break;
//               case 'Help & Feedback':
//                 Navigator.of(context).pushNamed('/help-feedback-page');
//                 break;
//             }
//           },
//           itemBuilder: (BuildContext context) {
//             return [
//               PopupMenuItem<String>(
//                 value: 'Delete',
//                 child: Text('Delete'),
//               ),
//               PopupMenuItem<String>(
//                 value: 'Help & Feedback',
//                 child: Text('Help & Feedback'),
//               ),
//             ];
//           },
//         )
//       ],
//     );
//   }

//   void _showDeleteConfirmationDialog(context, ColorScheme colorScheme) {
//     showDialog(
//       context: context,
//       builder: (_) {
//         return BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
//           child: AlertDialog(
//             surfaceTintColor: colorScheme.background.withOpacity(0.8),
//             title: Text('Delete Confirmation'),
//             content: Text('Are you sure you want to delete ${product.name}?'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop(); // Close the dialog
//                 },
//                 child: Text('Cancel'),
//               ),
//               TextButton(
//                 onPressed: () {
//                   _detailsBloc.add(DeleteProductEvent(product));
//                   Navigator.of(context).pop();
//                   Navigator.of(context)
//                       .pushReplacementNamed('/seller-products-page');
//                 },
//                 child: Text(
//                   'Delete',
//                   style: TextStyle(
//                     color: Colors.red,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// class SellerProductDetailsPage extends StatefulWidget {
//   const SellerProductDetailsPage({super.key});

//   @override
//   State<SellerProductDetailsPage> createState() =>
//       _SellerProductDetailsPageState();
// }

// class _SellerProductDetailsPageState extends State<SellerProductDetailsPage> {
//   late Products product;
//   int _currentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;
//     product = ModalRoute.of(context)!.settings.arguments as Products;
//     return Scaffold(
//       appBar: _buildAppBar(context, colorScheme),
//       body: _buidBodyContents(colorScheme),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.edit_outlined),
//         onPressed: () {
//           Navigator.pushNamed(
//             context,
//             '/add-product-page',
//             arguments: product,
//           );
//         },
//       ),
//     );
//   }

//   AppBar _buildAppBar(BuildContext context, ColorScheme colorScheme) {
//     return AppBar(
//       title: Text('Details'),
//       actions: [
//         PopupMenuButton(
//           onSelected: (String choice) {
//             switch (choice) {
//               case 'Delete':
//                 _showDeleteConfirmationDialog(context, colorScheme);
//                 break;
//               case 'Help & Feedback':
//                 Navigator.of(context).pushNamed('/help-feedback-page');
//                 break;
//             }
//           },
//           itemBuilder: (BuildContext context) {
//             return [
//               PopupMenuItem<String>(
//                 value: 'Delete',
//                 child: Text('Delete'),
//               ),
//               PopupMenuItem<String>(
//                 value: 'Help & Feedback',
//                 child: Text('Help & Feedback'),
//               ),
//             ];
//           },
//         )
//       ],
//     );
//   }

//   Padding _buidBodyContents(ColorScheme colorScheme) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         children: [
//           Card(
//             color: Colors.black87,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   CarouselSlider(
//                     options: CarouselOptions(
//                       pauseAutoPlayOnTouch: true,
//                       enlargeCenterPage: true,
//                       pauseAutoPlayOnManualNavigate: true,
//                       autoPlay: true,
//                       // viewportFraction: 0.8,
//                       autoPlayInterval: Duration(seconds: 4),
//                       autoPlayCurve: Curves.easeInOut,
//                       onPageChanged: (index, reason) {
//                         setState(() {
//                           _currentIndex = index;
//                         });
//                       },
//                     ),
//                     items: product.imageUrls.map((imageUrl) {
//                       return Builder(
//                         builder: (BuildContext context) {
//                           return Stack(
//                             alignment: Alignment.center,
//                             children: [
//                               if (product.imageUrls.isNotEmpty)
//                                 CachedNetworkImage(
//                                   imageUrl: imageUrl,
//                                   fit: BoxFit.cover,
//                                 ),
//                               if (imageUrl.isEmpty)
//                                 Center(child: CircularProgressIndicator())
//                             ],
//                           );
//                         },
//                       );
//                     }).toList(),
//                   ),
//                   SizedBox(height: 4),
//                   Card(
//                     color: colorScheme.secondaryContainer,
//                     child: Padding(
//                       padding: const EdgeInsets.all(2.0),
//                       child: AnimatedContainer(
//                         duration: Duration(milliseconds: 300),
//                         child: product.imageUrls.isNotEmpty
//                             ? DotsIndicator(
//                                 dotsCount: product.imageUrls.length,
//                                 position: _currentIndex,
//                                 decorator: DotsDecorator(
//                                   activeColor: colorScheme.primary,
//                                   color: colorScheme.onSurfaceVariant,
//                                   activeSize: Size(10, 10),
//                                   size: Size(8, 8),
//                                   activeShape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(5),
//                                   ),
//                                   spacing: EdgeInsets.all(4),
//                                 ),
//                               )
//                             : SizedBox.shrink(),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Card(
//             elevation: 3,
//             child: Column(
//               children: [
//                 ListTile(
//                   // tileColor: colorScheme.secondaryContainer,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(64))),
//                   title: Text('Name: ${product.name}'),
//                 ),
//                 ListTile(
//                   // tileColor: colorScheme.secondaryContainer,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(64))),
//                   title: Text('Category: ${product.catergory}'),
//                 ),
//                 ListTile(
//                   // tileColor: colorScheme.secondaryContainer,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(64))),
//                   title: Text('Price: ₹ ${product.price}'),
//                 ),
//                 ListTile(
//                   // tileColor: colorScheme.secondaryContainer,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(64))),
//                   title: Text('Quantity: ${product.quantity}'),
//                 ),
//                 ListTile(
//                   // tileColor: colorScheme.secondaryContainer,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(64))),
//                   title: Text('Description: ${product.description}'),
//                 ),
//                 ListTile(
//                   // tileColor: colorScheme.secondaryContainer,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(64))),
//                   title: Text('Unique ID: ${product.id}'),
//                 ),
//               ],
//             ),
//           ),
//           Divider(),
//           Card(
//             color: colorScheme.primaryContainer,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [Text('Status: ${product.status}')],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   void _showDeleteConfirmationDialog(context, ColorScheme colorScheme) {
//     showDialog(
//       context: context,
//       builder: (_) {
//         return BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
//           child: AlertDialog(
//             surfaceTintColor: colorScheme.background.withOpacity(0.8),
//             title: Text('Delete Confirmation'),
//             content: Text('Are you sure you want to delete ${product.name}?'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop(); // Close the dialog
//                 },
//                 child: Text('Cancel'),
//               ),
//               TextButton(
//                 onPressed: () async {
//                   await _deleteProduct(context, product, colorScheme);
//                   Navigator.of(context).pop();
//                   Navigator.of(context)
//                       .pushReplacementNamed('/seller-products-page');
//                 },
//                 child: Text(
//                   'Delete',
//                   style: TextStyle(
//                     color: Colors.red,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Future<void> _deleteProduct(
//     context,
//     Products product,
//     ColorScheme colorScheme,
//   ) async {
//     try {
//       CollectionReference productsCollection =
//           FirebaseFirestore.instance.collection('Products Test');
//       CollectionReference imagesCollection =
//           FirebaseFirestore.instance.collection('ProductImages Test');
//       CollectionReference usersCollection =
//           FirebaseFirestore.instance.collection('Users');

//       // Delete the product document
//       await productsCollection.doc(product.id).delete();

//       // Delete associated images
//       QuerySnapshot imagesSnapshot = await imagesCollection
//           .where('productId', isEqualTo: product.id)
//           .get();
//       for (QueryDocumentSnapshot imageDoc in imagesSnapshot.docs) {
//         // Delete image from storage
//         // String imagePath = imageDoc.data()?['imageUrl']?? '';
//         // Reference storageReference =
//         //     FirebaseStorage.instance.refFromURL(imagePath);
//         // await storageReference.delete();

//         // Delete the image document
//         await imageDoc.reference.delete();
//       }

//       // Remove the product ID from the user's document
//       String userUid = FirebaseAuth.instance.currentUser!.uid;
//       DocumentReference userDocRef = usersCollection.doc(userUid);
//       await userDocRef.update({
//         'productIds': FieldValue.arrayRemove([product.id]),
//       });

//       // Show success dialog
//       await showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             surfaceTintColor: colorScheme.background.withOpacity(0.8),
//             title: Text('Success'),
//             content: Text('Product deleted successfully'),
//             actions: [
//               TextButton(
//                 child: Text('OK'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           );
//         },
//       );
//     } catch (e) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Error'),
//             content: Text('Failed to delete product'),
//             actions: [
//               TextButton(
//                 child: Text('OK'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }
// }
