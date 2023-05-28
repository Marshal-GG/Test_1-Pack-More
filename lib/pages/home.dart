import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart';

class MyData {
  late final String name;
  late final int age;

  MyData({required this.name, required this.age});
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: buildAppBar(context),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 45),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Welcome!",
                  style: GoogleFonts.alata(
                      fontWeight: FontWeight.w900,
                      fontSize: 38,
                      color: colorScheme.onBackground),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 20,
            child: Column(
              children: [
                Expanded(
                  flex: 5,
                  child: CarouselSlider(
                    options: CarouselOptions(
                      enlargeCenterPage: true,
                      pauseAutoPlayOnManualNavigate: true,
                      autoPlay: true,
                      viewportFraction: 0.8,
                      autoPlayInterval: Duration(seconds: 2),
                      autoPlayCurve: Curves.easeInOut,
                    ),
                    items: [
                      TopBannerCards(
                        colorScheme: colorScheme,
                        imgurl: 'assets/images/stocks/1.png',
                        title: 'The Fastest in Delivery!!',
                        buttonTextColor: colorScheme.secondaryContainer,
                        cardColor: colorScheme.secondaryContainer,
                        titleColor: colorScheme.onSecondaryContainer,
                      ),
                      TopBannerCards(
                        colorScheme: colorScheme,
                        imgurl: 'assets/images/stocks/2.png',
                        title: 'The Fastest in Delivery!!',
                        buttonTextColor: colorScheme.tertiaryContainer,
                        cardColor: colorScheme.tertiaryContainer,
                        titleColor: colorScheme.onTertiaryContainer,
                      ),
                      TopBannerCards(
                        colorScheme: colorScheme,
                        imgurl: 'assets/images/stocks/3.png',
                        title: 'The Fastest in Delivery!!',
                        buttonTextColor: colorScheme.primaryContainer,
                        cardColor: colorScheme.primaryContainer,
                        titleColor: colorScheme.onPrimaryContainer,
                      ),
                      TopBannerCards(
                        colorScheme: colorScheme,
                        imgurl: 'assets/images/stocks/4.png',
                        title: 'The Fastest in Delivery!!',
                        buttonTextColor: colorScheme.errorContainer,
                        cardColor: colorScheme.errorContainer,
                        titleColor: colorScheme.onErrorContainer,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 10),
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
                          child: Row(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: [
        Padding(
          padding: EdgeInsets.all(12),
          child: SizedBox(
            width: 33,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(100),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  size: 17.5,
                  color: colorScheme.onSurfaceVariant,
                ),
                onPressed: () {},
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(12),
          child: SizedBox(
            width: 33,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(100),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.sunny,
                  size: 17.5,
                  color: colorScheme.onSurfaceVariant,
                ),
                onPressed: () {},
              ),
            ),
          ),
        ),
        SizedBox(width: 8)
      ],
      title: Text(
        "Home",
        style: TextStyle(
          color: colorScheme.primary,
          fontWeight: FontWeight.w700,
        ),
      ),
      centerTitle: false,
    );
  }
}

class TopBannerCards extends StatelessWidget {
  const TopBannerCards({
    super.key,
    required this.colorScheme,
    required this.imgurl,
    required this.title,
    required this.cardColor,
    required this.titleColor,
    required this.buttonTextColor,
  });

  final ColorScheme colorScheme;
  final String imgurl;
  final String title;
  final Color cardColor;
  final Color titleColor;
  final Color buttonTextColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 20,
      ),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow,
              spreadRadius: -5,
              blurRadius: 14,
              offset: Offset(2, 8),
            )
          ],
          borderRadius: BorderRadius.circular(40),
          color: cardColor,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Transform.scale(
                scale: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 24,
                            wordSpacing: 2.5,
                            height: 1.4,
                            letterSpacing: -0.7,
                            color: titleColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 17,
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(titleColor),
                          ),
                          child: Text(
                            "Order Now",
                            style: TextStyle(
                              color: buttonTextColor,
                              fontSize: 16,
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Transform.scale(
                scale: 1.7,
                child: Transform.scale(
                  scale: 0.7,
                  child: Image.asset(imgurl),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
