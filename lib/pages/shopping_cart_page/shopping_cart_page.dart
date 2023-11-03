import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../core/models/models.dart';
import 'bloc/shopping_cart_page_bloc.dart';

class ShoppingCartPage extends StatefulWidget {
  ShoppingCartPage({super.key});

  @override
  State<ShoppingCartPage> createState() => _CartPageState();
}

class _CartPageState extends State<ShoppingCartPage> {
  final TextEditingController _couponController = TextEditingController();

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
        if (state is ShoppingCartLoaded && state.cartItems.isNotEmpty) {
          final bloc = BlocProvider.of<ShoppingCartPageBloc>(context);
          final cartItems = state.cartItems;
          final products = state.products;
          final totalPrice = state.totalPrice;
          return Scaffold(
            appBar: AppBar(title: Text('My Shopping Cart')),
            body: buildBody(cartItems, products, colorScheme, bloc),
            bottomNavigationBar:
                buildBottomNavigationBar(colorScheme, totalPrice, cartItems),
          );
        } else if (state is ShoppingCartLoaded && state.cartItems.isEmpty) {
          return Scaffold(
              body: Center(child: Text('Your shopping cart is empty.')));
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
          color: colorScheme.surface,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -15),
              blurRadius: 20,
              color: colorScheme.onSurface.withOpacity(0.1),
            )
          ],
        ),
        child: SafeArea(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  // height: 50,
                  // width: 50,
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
                Gap(10),
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
                Spacer(),
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
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          buildCartProducts(cartItems, products, colorScheme, bloc),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Divider(),
                buildPriceDetailsCard(),
                Divider(),
                buildAddCoupon(colorScheme)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Card buildAddCoupon(ColorScheme colorScheme) {
    return Card(
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 250,
              height: 40,
              child: TextField(
                controller: _couponController,
                textAlign: TextAlign.left,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Add Coupon (optional)',
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                ),
                style: TextStyle(
                  color: colorScheme.primary,
                  fontSize: 16,
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
            Gap(10),
            SizedBox(
              width: 80,
              height: 40,
              child: ElevatedButton(
                onPressed: _couponController.text.isEmpty ? null : () {},
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: colorScheme.primaryContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Apply",
                    style: TextStyle(
                      color: colorScheme.onPrimaryContainer,
                    ),
                    overflow: TextOverflow.visible,
                    maxLines: 1,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  SliverList buildCartProducts(
      List<ShoppingCart> cartItems,
      List<Products> products,
      ColorScheme colorScheme,
      ShoppingCartPageBloc bloc) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: cartItems.length,
        (context, index) {
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
                            tag: product.name,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image(
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(
                                    product.imageUrl),
                              ),
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
                          Text(
                            ' X ${cartItems[index].quantity}',
                            style: TextStyle(
                                color:
                                    colorScheme.onBackground.withOpacity(0.5)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  subtitle: Column(
                    children: [
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton.filledTonal(
                            onPressed: () {
                              bloc.add(
                                UpdateCartProductQuantity(
                                  product: product,
                                  quantity: cartItems[index].quantity - 1,
                                ),
                              );
                            },
                            color: Colors.red,
                            icon: Icon(
                              Icons.remove,
                            ),
                          ),
                          Gap(5),
                          SizedBox(
                            width: 48,
                            height: 30,
                            child: TextField(
                              controller: TextEditingController(
                                  text: cartItems[index].quantity.toString()),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: colorScheme.primary,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              style: TextStyle(
                                color: colorScheme.primary,
                                fontSize: 16,
                              ),
                              onSubmitted: (value) {
                                if (value.isNotEmpty) {
                                  bloc.add(
                                    UpdateCartProductQuantity(
                                      product: product,
                                      quantity: int.parse(value),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                          Gap(5),
                          IconButton.filledTonal(
                            onPressed: () {
                              bloc.add(
                                UpdateCartProductQuantity(
                                  product: product,
                                  quantity: cartItems[index].quantity + 1,
                                ),
                              );
                            },
                            color: Colors.green,
                            icon: Icon(
                              Icons.add,
                            ),
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
        },
      ),
    );
  }

  Card buildPriceDetailsCard() {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              'Price Details',
              style: TextStyle(fontSize: 20),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Gap(5),
                Row(
                  children: [
                    Text('Price (1 item)'),
                    Spacer(),
                    Text(
                      '₹1,234',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Discount'),
                    Spacer(),
                    Text(
                      '-₹60',
                      style: TextStyle(fontSize: 16, color: Colors.green),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Delivery Charges'),
                    Spacer(),
                    Text(
                      '₹40',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(),
                    Text(
                      '₹2,000',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
