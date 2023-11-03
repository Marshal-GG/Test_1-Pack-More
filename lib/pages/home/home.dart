import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../core/models/models.dart';
import '../../core/widgets/custom_drawer.dart';
import 'bloc/home_page_bloc.dart';
import 'components/banner_card.dart';
import 'components/category.dart';
import 'components/popular_now.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DrawerSelectionState>(
      builder: (context, drawerSelection, child) {
        final colorScheme = Theme.of(context).colorScheme;
        return BlocBuilder<HomePageBloc, HomePageState>(
          builder: (context, state) {
            if (state is HomePageLoaded) {
              return buildMainScaffold(context, state, colorScheme);
            } else {
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            }
          },
        );
      },
    );
  }

  Scaffold buildMainScaffold(
      BuildContext context, HomePageState state, ColorScheme colorScheme) {
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
            CategoryWidget(state: state),
            PopularCategoryWidget(
              state: state,
              colorScheme: colorScheme,
            ),
            Divider(
              indent: 25,
              endIndent: 25,
              color: colorScheme.outlineVariant,
            ),
            BannerCardWidget(colorScheme: colorScheme),
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
              onPressed: () {
                Navigator.pushNamed(context, '/shopping-cart-page');
              },
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
