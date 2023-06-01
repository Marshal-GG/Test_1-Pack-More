import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/getx/category_controller_getx.dart';
import '../../../core/firebase_services.dart';
import '../../../models/product_model.dart';

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

    setState(() {
      products = fetchedProducts;
    });
  }

  Future<String> getDownloadUrl(String storageLocation) async {
    try {
      Reference ref = FirebaseStorage.instance.refFromURL(storageLocation);
      String downloadURL = await ref.getDownloadURL();
      print(downloadURL);
      return downloadURL;
    } catch (e) {
      print('Failed to get download URL: $e');
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 0,
      child: Column(
        children: [
          Padding(
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
                  onTap: () {},
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
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
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: GetBuilder<CategoryControllerGetx>(
              builder: (carouselController) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: products.map((e) {
                        int id = carouselController.categoryModelGetx.i + 1;
                        return (e.id == id)
                            ? GestureDetector(
                                onTap: () {},
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(height: 8),
                                          SizedBox(
                                            height: 140,
                                            width: 180,
                                            child: Hero(
                                                tag: e.name,
                                                child: Image.network(
                                                  e.image,
                                                  semanticLabel: e.name,
                                                )),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            e.name,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: widget
                                                  .colorScheme.onSurfaceVariant,
                                            ),
                                          ),
                                          Text(
                                            e.category,
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.normal,
                                              color:
                                                  widget.colorScheme.tertiary,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            '₹ ${e.price}',
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
          )
        ],
      ),
    );
  }
}

class CategoryWidget extends StatefulWidget {
  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  List<DocumentSnapshot> category = [];
  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  void fetchCategories() async {
    CollectionReference categoryRef =
        FirebaseFirestore.instance.collection('categories');
    QuerySnapshot querySnapshot = await categoryRef.get();
    setState(() {
      category = querySnapshot.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final categoryController = Get.find<CategoryControllerGetx>();

    // CollectionReference categories =
    //     FirebaseFirestore.instance.collection("categories");
    // final FirebaseFirestore firestore = FirebaseFirestore.instance;

    return Expanded(
      flex: 0,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 8),
        child: Column(
          children: [
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            //   child: Align(
            //     alignment: Alignment.centerLeft,
            //     child: Text(
            //       "Categories",
            //       style: TextStyle(
            //         fontWeight: FontWeight.w800,
            //         fontSize: 23,
            //       ),
            //     ),
            //   ),
            // ),
            Hero(
              tag: "category",
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: category
                      .map(
                        (e) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: ActionChip(
                            label: Text(
                              e['name'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color:
                                    (categoryController.categoryModelGetx.i ==
                                            category.indexOf(e))
                                        ? colorScheme.background
                                        : colorScheme.onBackground,
                              ),
                            ),
                            backgroundColor:
                                (categoryController.categoryModelGetx.i ==
                                        category.indexOf(e))
                                    ? colorScheme.primary
                                    : colorScheme.background,
                            elevation:
                                (categoryController.categoryModelGetx.i ==
                                        category.indexOf(e))
                                    ? 6
                                    : 0,
                            onPressed: () {
                              setState(() {
                                categoryController.changeCategory(
                                  temp: category.indexOf(e),
                                );
                              });
                            },
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TopBannerCardWidget extends StatefulWidget {
  const TopBannerCardWidget({
    super.key,
    required this.colorScheme,
  });

  final ColorScheme colorScheme;

  @override
  State<TopBannerCardWidget> createState() => _TopBannerCardWidgetState();
}

class _TopBannerCardWidgetState extends State<TopBannerCardWidget> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      // width: screenWidth,
      constraints: BoxConstraints.tight(Size.fromHeight(screenHeight / 3.5)),
      child: Column(
        children: [
          Expanded(
            child: CarouselSlider(
              options: CarouselOptions(
                  enlargeCenterPage: true,
                  pauseAutoPlayOnManualNavigate: true,
                  autoPlay: true,
                  viewportFraction: 0.8,
                  autoPlayInterval: Duration(seconds: 4),
                  autoPlayCurve: Curves.easeInOut,
                  onPageChanged: ((index, _) {
                    setState(() {
                      _currentIndex = index;
                    });
                  })),
              items: [
                TopBannerCards(
                  colorScheme: widget.colorScheme,
                  imgurl: 'assets/images/stocks/1.png',
                  title: 'The Fastest in Delivery!!',
                  buttonTextColor: widget.colorScheme.secondaryContainer,
                  cardColor: widget.colorScheme.secondaryContainer,
                  titleColor: widget.colorScheme.onSecondaryContainer,
                  onPress: () {},
                ),
                TopBannerCards(
                  colorScheme: widget.colorScheme,
                  imgurl: 'assets/images/stocks/2.png',
                  title: 'The Safest in Delivery!!',
                  buttonTextColor: widget.colorScheme.tertiaryContainer,
                  cardColor: widget.colorScheme.tertiaryContainer,
                  titleColor: widget.colorScheme.onTertiaryContainer,
                  onPress: () {},
                ),
                TopBannerCards(
                  colorScheme: widget.colorScheme,
                  imgurl: 'assets/images/stocks/3.png',
                  title: 'The Achievement in Delivery!!',
                  buttonTextColor: widget.colorScheme.primaryContainer,
                  cardColor: widget.colorScheme.primaryContainer,
                  titleColor: widget.colorScheme.onPrimaryContainer,
                  onPress: () {},
                ),
                TopBannerCards(
                  colorScheme: widget.colorScheme,
                  imgurl: 'assets/images/stocks/4.png',
                  title: 'The Hotest in Delivery!!',
                  buttonTextColor: widget.colorScheme.errorContainer,
                  cardColor: widget.colorScheme.errorContainer,
                  titleColor: widget.colorScheme.onErrorContainer,
                  onPress: () {},
                ),
              ],
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            child: DotsIndicator(
              dotsCount: 4,
              position: _currentIndex,
              decorator: DotsDecorator(
                activeColor: widget.colorScheme.primary,
                color: widget.colorScheme.onSurfaceVariant,
                activeSize: Size(12, 12),
                size: Size(10, 10),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                spacing: EdgeInsets.all(4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TopBannerCards extends StatelessWidget {
  const TopBannerCards({
    Key? key,
    required this.colorScheme,
    required this.imgurl,
    required this.title,
    required this.cardColor,
    required this.titleColor,
    required this.buttonTextColor,
    required this.onPress,
  }) : super(key: key);

  final ColorScheme colorScheme;
  final String imgurl;
  final String title;
  final Color cardColor;
  final Color titleColor;
  final Color buttonTextColor;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(20),
        color: cardColor,
        child: SizedBox(
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 20,
                            wordSpacing: 2.5,
                            height: 1.4,
                            letterSpacing: -0.7,
                            color: titleColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Flexible(
                        child: ElevatedButton(
                          onPressed: onPress,
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(4.0),
                            backgroundColor:
                                MaterialStateProperty.all(titleColor),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            )),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            )),
                          ),
                          child: Text(
                            "Order Now",
                            style: TextStyle(
                              color: buttonTextColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Align(
                    alignment: Alignment.center,
                    child: FractionallySizedBox(
                      widthFactor: 0.9,
                      child: Material(
                        elevation: 8,
                        borderRadius: BorderRadius.circular(30),
                        clipBehavior: Clip.antiAlias,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            imgurl,
                            scale: 1.5,
                            fit: BoxFit.cover,
                          ),
                        ),
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
}

// class TopBannerCards extends StatelessWidget {
//   const TopBannerCards({
//     Key? key,
//     required this.colorScheme,
//     required this.imgurl,
//     required this.title,
//     required this.cardColor,
//     required this.titleColor,
//     required this.buttonTextColor,
//   }) : super(key: key);

//   final ColorScheme colorScheme;
//   final String imgurl;
//   final String title;
//   final Color cardColor;
//   final Color titleColor;
//   final Color buttonTextColor;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
//       child: Material(
//         elevation: 8,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(40),
//         ),
//         color: cardColor,
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Expanded(
//               flex: 4,
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       title,
//                       style: TextStyle(
//                         fontSize: MediaQuery.of(context).size.width * 0.04,
//                         wordSpacing: 2.5,
//                         height: 1.4,
//                         letterSpacing: -0.7,
//                         color: titleColor,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         primary: titleColor,
//                         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       child: Text(
//                         "Order Now",
//                         style: TextStyle(
//                           color: buttonTextColor,
//                           fontSize: MediaQuery.of(context).size.width * 0.035,
//                         ),
//                       ),
//                       onPressed: () {},
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Expanded(
//               flex: 5,
//               child: AspectRatio(
//                 aspectRatio: 3 / 2,
//                 child: Image.asset(imgurl, fit: BoxFit.cover),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
