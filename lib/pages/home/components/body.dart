
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/getx/category_controller_getx.dart';
import '../../../models/resources.dart';

class PopularCategoryWidget extends StatelessWidget {
  const PopularCategoryWidget({
    super.key,
    required this.colorScheme,
  });

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 8,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 35, right: 30),
            child: Row(
              children: [
                Text(
                  'Popular Now!',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                    color: colorScheme.onBackground,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'View All ▶️',
                    style: TextStyle(
                      fontSize: 14,
                      color: colorScheme.error,
                      fontWeight: FontWeight.bold,
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
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: allProducts.map((e) {
                        int id = carouselController.categoryModelGetx.i + 1;
                        return (e.id == id)
                            ? GestureDetector(
                                onTap: () {},
                                child: Padding(
                                  padding: EdgeInsets.only(left: 8, bottom: 8),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    elevation: 4,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 8),
                                        SizedBox(
                                          height: 120,
                                          width: 160,
                                          child: Hero(
                                            tag: e.name,
                                            child: Image.asset(
                                              e.image,
                                              semanticLabel: e.name,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          e.name,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: colorScheme.onSurfaceVariant,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          '₹ ${e.price}',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: colorScheme.error,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                      ],
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

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Expanded(
      flex: 3,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Categories",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 23,
                ),
              ),
            ),
          ),
          Hero(
            tag: "category",
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: category
                    .map(
                      (e) => GetBuilder<CategoryControllerGetx>(
                          builder: (categoryController) {
                        return Padding(
                          padding: EdgeInsets.only(
                            left: 10,
                            top: 10,
                            bottom: 10,
                          ),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all(
                                  (categoryController.categoryModelGetx.i ==
                                          category.indexOf(e))
                                      ? 6
                                      : 0),
                              backgroundColor: MaterialStateProperty.all(
                                (categoryController.categoryModelGetx.i ==
                                        category.indexOf(e))
                                    ? colorScheme.primaryContainer
                                    : colorScheme.tertiaryContainer,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(13),
                              child: Row(
                                children: [
                                  Text(
                                    e['name'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: (categoryController
                                                    .categoryModelGetx.i ==
                                                category.indexOf(e))
                                            ? colorScheme.onPrimaryContainer
                                            : colorScheme.onTertiaryContainer),
                                  )
                                ],
                              ),
                            ),
                            onPressed: () {
                              categoryController.changeCategory(
                                temp: category.indexOf(e),
                              );
                            },
                          ),
                        );
                      }),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
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
    return Expanded(
      flex: 5,
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
                ),
                TopBannerCards(
                  colorScheme: widget.colorScheme,
                  imgurl: 'assets/images/stocks/2.png',
                  title: 'The Safest in Delivery!!',
                  buttonTextColor: widget.colorScheme.tertiaryContainer,
                  cardColor: widget.colorScheme.tertiaryContainer,
                  titleColor: widget.colorScheme.onTertiaryContainer,
                ),
                TopBannerCards(
                  colorScheme: widget.colorScheme,
                  imgurl: 'assets/images/stocks/3.png',
                  title: 'The Achievement in Delivery!!',
                  buttonTextColor: widget.colorScheme.primaryContainer,
                  cardColor: widget.colorScheme.primaryContainer,
                  titleColor: widget.colorScheme.onPrimaryContainer,
                ),
                TopBannerCards(
                  colorScheme: widget.colorScheme,
                  imgurl: 'assets/images/stocks/4.png',
                  title: 'The Hotest in Delivery!!',
                  buttonTextColor: widget.colorScheme.errorContainer,
                  cardColor: widget.colorScheme.errorContainer,
                  titleColor: widget.colorScheme.onErrorContainer,
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
  }) : super(key: key);

  final ColorScheme colorScheme;
  final String imgurl;
  final String title;
  final Color cardColor;
  final Color titleColor;
  final Color buttonTextColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
      child: Material(
        borderRadius: BorderRadius.circular(40),
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
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 20,
                          wordSpacing: 2.5,
                          height: 1.4,
                          letterSpacing: -0.7,
                          color: titleColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(titleColor),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          )),
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
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
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Align(
                  alignment: Alignment.center,
                  child: FractionallySizedBox(
                    widthFactor: 0.7,
                    child: Material(
                      elevation: 8,
                      borderRadius: BorderRadius.circular(30),
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset(
                        imgurl,
                        scale: 1.5,
                        fit: BoxFit.cover,
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
