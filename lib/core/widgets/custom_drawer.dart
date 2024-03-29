import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/drawer_selection_model.dart';
import '../routes/routes_config.dart';

class CustomDrawerWidget extends StatefulWidget {
  const CustomDrawerWidget({super.key});

  @override
  State<CustomDrawerWidget> createState() => _CustomDrawerWidgetState();
}

class _CustomDrawerWidgetState extends State<CustomDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final selectedItem =
        Provider.of<DrawerSelectionState>(context).selectedItem;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
      child: Drawer(
        backgroundColor: colorScheme.background.withOpacity(0.8),
        child: SafeArea(
          child: SingleChildScrollView(
              child: Column(
            children: [
              // Divider(),
              Text(
                'Pack More',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              Divider(),
              // UserAccountsDrawerHeader(
              //   accountName: Text('Marshal'),
              //   accountEmail: Text('marshalgcom@gmail.com'),
              //   currentAccountPicture: CachedNetworkImage(
              //       imageUrl:
              //           'https://lh3.googleusercontent.com/a/AAcHTtfzfevw75epBsjOeQTFHSCJQHrlUvXalRprzx39-A=s96-c'),
              // ),
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: ListTile(
                  leading: Icon(Icons.admin_panel_settings_outlined),
                  title: Text(
                    'Admin Panel',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  onTap: () {
                    Provider.of<DrawerSelectionState>(context, listen: false)
                        .setSelectedItem('/admin-panel-options-page');
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/admin-panel-options-page');
                  },
                  selected: selectedItem == '/admin-panel-options-page',
                  enableFeedback: true,
                  selectedColor: colorScheme.onSurface,
                  selectedTileColor:
                      colorScheme.surfaceVariant.withOpacity(0.6),
                  dense: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(64),
                      bottomRight: Radius.circular(64),
                    ),
                  ),
                ),
              ),
              Divider(),
              CustomDrawerItems(
                leadingIcon: Icon(Icons.home_outlined),
                title: 'Home',
                selectedItemName: selectedItem == '/home-page',
                colorScheme: colorScheme,
                onTap: () {
                  final drawerSelectionState =
                      Provider.of<DrawerSelectionState>(context, listen: false);
                  if (drawerSelectionState.selectedItem != '/home-page') {
                    drawerSelectionState.setSelectedItem('/home-page');
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/home-page');
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
              CustomDrawerItems(
                leadingIcon: Icon(Icons.shopping_cart_outlined),
                title: 'Shopping Cart',
                selectedItemName: selectedItem == '/shopping-cart-page',
                colorScheme: colorScheme,
                onTap: () {
                  final drawerSelectionState =
                      Provider.of<DrawerSelectionState>(context, listen: false);
                  if (drawerSelectionState.selectedItem !=
                      '/shopping-cart-page') {
                    drawerSelectionState.setSelectedItem('/shopping-cart-page');
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/shopping-cart-page');
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
              CustomDrawerItems(
                leadingIcon: Icon(Icons.inventory_outlined),
                title: 'Orders',
                selectedItemName: selectedItem == '/orders-page',
                colorScheme: colorScheme,
                onTap: () {
                  final drawerSelectionState =
                      Provider.of<DrawerSelectionState>(context, listen: false);
                  if (drawerSelectionState.selectedItem != '/orders-page') {
                    drawerSelectionState.setSelectedItem('/orders-page');
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/orders-page');
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
              CustomDrawerItems(
                leadingIcon: Icon(Icons.person_outline),
                title: 'Profile',
                selectedItemName: selectedItem == '/user-profile-page',
                colorScheme: colorScheme,
                onTap: () {
                  final drawerSelectionState =
                      Provider.of<DrawerSelectionState>(context, listen: false);
                  if (drawerSelectionState.selectedItem !=
                      '/user-profile-page') {
                    drawerSelectionState.setSelectedItem('/user-profile-page');
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/user-profile-page');
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: ListTile(
                  leading: Icon(Icons.format_list_bulleted),
                  title: Text(
                    'All Products List',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  onTap: () {
                    Provider.of<DrawerSelectionState>(context, listen: false)
                        .setSelectedItem('/seller-products-page');
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/seller-products-page');
                  },
                  selected: selectedItem == '/seller-products-page',
                  enableFeedback: true,
                  selectedColor: colorScheme.onSurface,
                  selectedTileColor:
                      colorScheme.surfaceVariant.withOpacity(0.6),
                  dense: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(64),
                      bottomRight: Radius.circular(64),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: ListTile(
                  leading: Icon(Icons.inventory_2_outlined),
                  title: Text(
                    'Add Product',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  onTap: () {
                    Provider.of<DrawerSelectionState>(context, listen: false)
                        .setSelectedItem('/add-product-page');
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/add-product-page');
                  },
                  selected: selectedItem == '/add-product-page',
                  enableFeedback: true,
                  selectedColor: colorScheme.onSurface,
                  selectedTileColor:
                      colorScheme.surfaceVariant.withOpacity(0.6),
                  dense: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(64),
                      bottomRight: Radius.circular(64),
                    ),
                  ),
                ),
              ),
              Divider(),

              CustomDrawerItems(
                leadingIcon: Icon(Icons.settings_outlined),
                title: 'Settings',
                selectedItemName: selectedItem == '/settings',
                colorScheme: colorScheme,
                onTap: () {
                  final drawerSelectionState =
                      Provider.of<DrawerSelectionState>(context, listen: false);
                  if (drawerSelectionState.selectedItem != '/settings') {
                    drawerSelectionState.setSelectedItem('/settings');
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/settings');
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
              CustomDrawerItems(
                leadingIcon: Icon(Icons.help_outline),
                title: 'Help & feedback',
                selectedItemName: selectedItem == '/help-feedback-page',
                colorScheme: colorScheme,
                onTap: () {
                  final drawerSelectionState =
                      Provider.of<DrawerSelectionState>(context, listen: false);
                  if (drawerSelectionState.selectedItem !=
                      '/help-feedback-page') {
                    drawerSelectionState.setSelectedItem('/help-feedback-page');
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/help-feedback-page');
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
              Divider(),
              CustomDrawerItems(
                leadingIcon: Icon(Icons.logout_outlined),
                title: 'Logout',
                selectedItemName: selectedItem == '/',
                colorScheme: colorScheme,
                onTap: () async {
                  await FirebaseService().signInWithGoogle();
                  Future.delayed(Duration.zero, () {
                    final drawerSelectionState =
                        Provider.of<DrawerSelectionState>(context,
                            listen: false);
                    if (drawerSelectionState.selectedItem != '/') {
                      drawerSelectionState.setSelectedItem('/');
                      Navigator.pop(context);
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/',
                        (route) => false,
                      );
                    } else {
                      Navigator.pop(context);
                    }
                  });
                },
              ),
            ],
          )),
        ),
      ),
    );
  }
}

class CustomDrawerItems extends StatelessWidget {
  const CustomDrawerItems({
    super.key,
    required this.colorScheme,
    required this.title,
    required this.onTap,
    required this.selectedItemName,
    required this.leadingIcon,
  });

  final String title;
  final bool selectedItemName;
  final ColorScheme colorScheme;
  final Function()? onTap;
  final Icon leadingIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: ListTile(
        leading: leadingIcon,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
        onTap: onTap,
        selected: selectedItemName,
        enableFeedback: true,
        selectedColor: colorScheme.onSurface,
        selectedTileColor: colorScheme.surfaceVariant.withOpacity(0.6),
        dense: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(64),
            bottomRight: Radius.circular(64),
          ),
        ),
      ),
    );
  }
}
