import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../core/controller/getx/category_controller_getx.dart';
import '../../core/models/drawer_selection_model.dart';
import '../../core/models/theme_model.dart';
import '../../core/widgets/custom_drawer.dart';
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
    return Consumer<DrawerSelectionState>(
      builder: (context, drawerSelection, child) {
        final colorScheme = Theme.of(context).colorScheme;
        return Scaffold(
          drawer: CustomDrawerWidget(),
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
                Divider(
                  indent: 25,
                  endIndent: 25,
                  color: colorScheme.outlineVariant,
                ),
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
      },
    );
  }

  AppBar buildAppBar(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 2,
      backgroundColor: Colors.transparent,
      // leading: IconButton(
      //   icon: Icon(
      //     Icons.menu_rounded,
      //     size: 17.5,
      //     color: colorScheme.onSurfaceVariant,
      //   ),
      //   onPressed: () {},
      // ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: SizedBox(
            width: 33,
            height: 33,
            child: IconButton.filledTonal(
              iconSize: 17.5,
              onPressed: () {
                Navigator.pushNamed(context, '/add-product-page');
              },
              icon: Icon(
                Icons.inventory_2_outlined,
                color: colorScheme.onSurface,
              ),
            ),
          ),
        ),

        // Shopping cart button
        Padding(
          padding: const EdgeInsets.all(12),
          child: SizedBox(
            width: 33,
            height: 33,
            child: IconButton.filledTonal(
              iconSize: 17.5,
              onPressed: () {},
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: colorScheme.onSurface,
              ),
            ),
          ),
        ),
        // Dark mode toggle button
        Padding(
          padding: const EdgeInsets.all(12),
          child: SizedBox(
            width: 33,
            height: 33,
            child: IconButton.filledTonal(
              iconSize: 17.5,
              onPressed: () {
                final provider =
                    Provider.of<ThemeProvider>(context, listen: false);
                provider.toggleTheme(!themeProvider.isDarkMode);
              },
              icon: themeProvider.isDarkMode
                  ? Icon(
                      Icons.wb_sunny_outlined,
                      color: colorScheme.onSurface,
                    )
                  : Icon(
                      Icons.dark_mode_outlined,
                      color: colorScheme.onSurface,
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
