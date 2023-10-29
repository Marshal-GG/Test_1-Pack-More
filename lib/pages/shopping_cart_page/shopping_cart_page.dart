import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/models/product_model.dart';
import '../../core/widgets/dot_divider.dart';
import 'bloc/shopping_cart_page_bloc.dart';
import 'package:test_1/core/models/shopping_cart_model.dart';

import 'components/coupon_entry_widget.dart';

class ShoppingCartPage extends StatefulWidget {
  ShoppingCartPage({super.key});

  @override
  State<ShoppingCartPage> createState() => _CartPageState();
}

class _CartPageState extends State<ShoppingCartPage> {
  @override
  void initState() {
    BlocProvider.of<ShoppingCartPageBloc>(context).add(LoadShoppingCart());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<ShoppingCartPageBloc, ShoppingCartPageState>(
      builder: (context, state) {
        if (state is ShoppingCartLoaded) {
          final bloc = BlocProvider.of<ShoppingCartPageBloc>(context);
          final cartItems = state.cartItems;
          final products = state.products;
          final totalPrice = state.totalPrice;
          return Scaffold(
            appBar: AppBar(title: Text('My Shopping Cart')),
            body: BlocBuilder<ShoppingCartPageBloc, ShoppingCartPageState>(
              builder: (context, state) {
                if (cartItems.isNotEmpty) {
                  return buildBody(cartItems, products, colorScheme, bloc);
                } else {
                  return Center(child: Text('Your shopping cart is empty.'));
                }
              },
            ),
            bottomNavigationBar:
                buildBottomNavigationBar(colorScheme, totalPrice, cartItems),
          );
        } else {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  SafeArea buildBottomNavigationBar(ColorScheme colorScheme, double totalPrice,
      List<ShoppingCart> cartItems) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: colorScheme.secondaryContainer,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -15),
              blurRadius: 20,
              color: colorScheme.surface.withOpacity(0.8),
            )
          ],
        ),
        child: SafeArea(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: colorScheme.onPrimaryContainer,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.receipt_long_outlined,
                    color: colorScheme.primaryContainer,
                    size: 24,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return CouponEntryWidget();
                      },
                    );
                  },
                  child: Card(
                    elevation: 0,
                    color: colorScheme.onSecondaryContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Text(
                            'Add coupon \n  (optional)',
                            style:
                                TextStyle(color: colorScheme.primaryContainer),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 12,
                            color: colorScheme.primaryContainer,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: 'Total \n',
                    style: TextStyle(
                        fontSize: 18, color: colorScheme.onPrimaryContainer),
                    children: [
                      TextSpan(
                        text: '₹ $totalPrice',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: cartItems.isEmpty
                        ? null
                        : () {
                            Navigator.pushNamed(context, '/check-out-page');
                          },
                    style: ElevatedButton.styleFrom(
                      elevation: 6,
                      backgroundColor: colorScheme.primaryContainer,
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "CHECK  OUT",
                      style: TextStyle(
                        color: colorScheme.onPrimaryContainer,
                        fontSize: 16,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        )),
      ),
    );
  }

  Padding buildBody(List<ShoppingCart> cartItems, List<Products> products,
      ColorScheme colorScheme, ShoppingCartPageBloc bloc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView.builder(
          itemCount: cartItems.length,
          itemBuilder: (context, index) {
            if (index < cartItems.length) {
              final Products product = products[index];
              return Dismissible(
                key: Key(cartItems[index].toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: colorScheme.error,
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: [
                      Spacer(),
                      Icon(Icons.delete_outline_rounded),
                    ],
                  ),
                ),
                onDismissed: (direction) {
                  bloc.add(RemoveFromCart(product: product));
                  // setState(() {
                  //   final int itemIndex = index;
                  //   final product = products[itemIndex];
                  //   if (itemIndex >= 0 && itemIndex < cartItems.length) {
                  //     cartItems.removeAt(itemIndex);
                  //     products.removeAt(itemIndex);
                  //     bloc.add(RemoveFromCart(product: product));
                  //   }
                  // });
                },
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 2,
                  child: ListTile(
                    leading: product.imageUrl.isNotEmpty
                        ? GestureDetector(
                            onLongPress: () {
                              Navigator.pushNamed(context, '/image-viewer-page',
                                  arguments: {
                                    'imagePath': null,
                                    'imageUrl': product.imageUrl,
                                  });
                            },
                            child: Hero(
                              tag: product.imageUrl,
                              child: CircleAvatar(
                                radius: 24,
                                backgroundImage: CachedNetworkImageProvider(
                                    product.imageUrl),
                              ),
                            ),
                          )
                        : CircularProgressIndicator.adaptive(),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete_outline_rounded,
                        size: 24,
                        color: colorScheme.error,
                      ),
                      onPressed: () {
                        bloc.add(RemoveFromCart(product: product));
                      },
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          products[index].name,
                          style: TextStyle(fontSize: 16),
                          maxLines: 2,
                        ),
                        SizedBox(height: 3),
                        Row(
                          children: [
                            Text(
                              '₹ ${product.price}',
                              style: TextStyle(color: colorScheme.primary),
                            ),
                            DotDivider(),
                            Text(
                              'Qty: ${cartItems[index].quantity}',
                              style: TextStyle(
                                  color: colorScheme.onBackground
                                      .withOpacity(0.5)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/product-details-page',
                        arguments: products[index],
                      );
                    },
                  ),
                ),
              );
            } else {
              return null;
            }
          }),
    );
  }
}
