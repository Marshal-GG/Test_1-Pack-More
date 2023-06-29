import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class BannerCardWidget extends StatefulWidget {
  const BannerCardWidget({
    super.key,
    required this.colorScheme,
  });

  final ColorScheme colorScheme;

  @override
  State<BannerCardWidget> createState() => _BannerCardWidgetState();
}

class _BannerCardWidgetState extends State<BannerCardWidget> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
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
                  BannerCards(
                    colorScheme: widget.colorScheme,
                    imgurl: 'assets/images/stocks/1.png',
                    title: 'The Fastest in Delivery!!',
                    buttonTextColor: widget.colorScheme.secondaryContainer,
                    cardColor: widget.colorScheme.secondaryContainer,
                    titleColor: widget.colorScheme.onSecondaryContainer,
                    onPress: () {
                      print('The Fastest in Delivery!!');
                    },
                  ),
                  BannerCards(
                    colorScheme: widget.colorScheme,
                    imgurl: 'assets/images/stocks/2.png',
                    title: 'The Safest in Delivery!!',
                    buttonTextColor: widget.colorScheme.tertiaryContainer,
                    cardColor: widget.colorScheme.tertiaryContainer,
                    titleColor: widget.colorScheme.onTertiaryContainer,
                    onPress: () {
                      print('The Safest in Delivery!!');
                    },
                  ),
                  BannerCards(
                    colorScheme: widget.colorScheme,
                    imgurl: 'assets/images/stocks/3.png',
                    title: 'The Achievement in Delivery!!',
                    buttonTextColor: widget.colorScheme.primaryContainer,
                    cardColor: widget.colorScheme.primaryContainer,
                    titleColor: widget.colorScheme.onPrimaryContainer,
                    onPress: () {
                      print('The Achievement in Delivery!!');
                    },
                  ),
                  BannerCards(
                    colorScheme: widget.colorScheme,
                    imgurl: 'assets/images/stocks/4.png',
                    title: 'The Hotest in Delivery!!',
                    buttonTextColor: widget.colorScheme.errorContainer,
                    cardColor: widget.colorScheme.errorContainer,
                    titleColor: widget.colorScheme.onErrorContainer,
                    onPress: () {
                      print('The Hotest in Delivery!!');
                    },
                  ),
                ],
              ),
            ),
          ],
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
    );
  }
}

class BannerCards extends StatelessWidget {
  const BannerCards({
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
                          style: ElevatedButton.styleFrom(
                            elevation: 4,
                            backgroundColor: titleColor,
                            padding: EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          // ButtonStyle(
                          //   elevation: MaterialStateProperty.all(4.0),
                          //   backgroundColor:
                          //       MaterialStateProperty.all(titleColor),
                          //   padding: MaterialStateProperty.all(
                          //       const EdgeInsets.symmetric(
                          //     horizontal: 24,
                          //     vertical: 12,
                          //   )),
                          //   shape: MaterialStateProperty.all(
                          //       RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(8),
                          //   )),
                          // ),
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

// class BannerCards extends StatelessWidget {
//   const BannerCards({
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
