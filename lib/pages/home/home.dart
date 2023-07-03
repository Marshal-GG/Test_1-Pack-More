import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../controller/getx/category_controller_getx.dart';
import '../../core/models/theme_model.dart';
import 'components/banner_card.dart';
import 'components/category.dart';
import 'components/popular_now.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Creating an instance of the CategoryControllerGetx
  final CategoryControllerGetx categoryController =
      Get.put(CategoryControllerGetx());

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(
          decelerationRate: ScrollDecelerationRate.fast,
        ),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            CategoryWidget(),
            PopularCategoryWidget(colorScheme: colorScheme),
            Divider(indent: 25, endIndent: 25),
            BannerCardWidget(colorScheme: colorScheme),

            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 45),
            //   child: Align(
            //     alignment: Alignment.center,
            //     child: Text(
            //       "Welcome!",
            //       style: GoogleFonts.alata(
            //           fontWeight: FontWeight.w900,
            //           fontSize: 38,
            //           color: colorScheme.onBackground),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(
          Icons.menu_rounded,
          size: 17.5,
          color: colorScheme.onSurfaceVariant,
        ),
        onPressed: () {},
      ),
      actions: [
        // Shopping cart button
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

        // Dark mode toggle button
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
                icon: themeProvider.isDarkMode
                    ? Icon(
                        Icons.sunny,
                        size: 17.5,
                        color: colorScheme.onSurfaceVariant,
                      )
                    : Icon(
                        Icons.dark_mode,
                        size: 17.5,
                        color: colorScheme.onSurfaceVariant,
                      ),
                onPressed: () {
                  final provider =
                      Provider.of<ThemeProvider>(context, listen: false);
                  provider.toggleTheme(!themeProvider.isDarkMode);
                },
              ),
            ),
          ),
        ),
        SizedBox(width: 8)
      ],
      title: Text(
        "Home",
        style: TextStyle(
          color: colorScheme.onBackground,
          fontWeight: FontWeight.w700,
        ),
      ),
      centerTitle: false,
    );
  }
}
