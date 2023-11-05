import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:test_1/core/widgets/dot_divider.dart';

import '../../../core/models/models.dart';
import '../../address_details_page/bloc/address_details_page_bloc.dart';
import '../../shopping_cart_page/bloc/shopping_cart_page_bloc.dart';
import 'bloc/check_out_page_bloc.dart';

class CheckoutPage extends StatefulWidget {
  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool hasEmptyData = true;

  @override
  void initState() {
    BlocProvider.of<AddressDetailsPageBloc>(context).add(LoadAddressDetails());
    BlocProvider.of<ShoppingCartPageBloc>(context).add(LoadShoppingCart());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<CheckoutPageBloc, CheckoutPageState>(
      builder: (context, state) {
        return buildBody(state, context, colorScheme);
      },
    );
  }

  Scaffold buildBody(
      CheckoutPageState state, BuildContext context, ColorScheme colorScheme) {
    return Scaffold(
      appBar: buildAppBar(state, context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  buildAddressCard(context, colorScheme),
                  Gap(20),
                ],
              ),
            ),
            buildCartProducts(colorScheme),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Gap(20),
                  buildPriceDetailsCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BlocBuilder<ShoppingCartPageBloc, ShoppingCartPageState> buildCartProducts(
      ColorScheme colorScheme) {
    return BlocBuilder<ShoppingCartPageBloc, ShoppingCartPageState>(
      builder: (context, state) {
        if (state is ShoppingCartLoaded && state.cartItems.isNotEmpty) {
          final cartItems = state.cartItems;
          final products = state.products;
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: cartItems.length,
              (context, index) {
                if (index < cartItems.length) {
                  final Products product = products[index];
                  return Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 2,
                    child: ListTile(
                      leading: product.imageUrl.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image(
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                  image: CachedNetworkImageProvider(
                                    product.imageUrl,
                                  ),
                                ),
                              ),
                            )
                          : CircularProgressIndicator.adaptive(),
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
                  );
                }
                return null;
              },
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Card buildPriceDetailsCard() {
    return Card(
      child: BlocBuilder<ShoppingCartPageBloc, ShoppingCartPageState>(
        builder: (context, state) {
          return Column(
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
                        Text('Sub-Total'),
                        Spacer(),
                        Text(
                          '₹${(state as ShoppingCartLoaded).subTotal.toString()}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Coupon Discount'),
                        Spacer(),
                        Text(
                          '₹-${state.couponDiscount.toString()}',
                          style: TextStyle(fontSize: 16, color: Colors.green),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Delivery Fee'),
                        Spacer(),
                        Text(
                          '₹${state.deliveryFee.toString()}',
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
                          '₹${state.totalPrice.toString()}',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  BlocBuilder<AddressDetailsPageBloc, AddressDetailsPageState> buildAddressCard(
      BuildContext context, ColorScheme colorScheme) {
    return BlocBuilder<AddressDetailsPageBloc, AddressDetailsPageState>(
      builder: (context, state) {
        if (state is AddressDetailsPageLoaded) {
          final ShippingAddress shippingAddress = state.shippingAddress;
          hasEmptyData = shippingAddress.name.isEmpty ||
              shippingAddress.phone.isEmpty ||
              shippingAddress.email.isEmpty ||
              shippingAddress.address.isEmpty ||
              shippingAddress.city.isEmpty ||
              shippingAddress.state.isEmpty ||
              shippingAddress.pincode.isEmpty;
          return Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Column(
              children: [
                ListTile(
                  title: Row(
                    children: [
                      Text(
                        'Shipping Address',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      OutlinedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, '/address-details-page');
                          },
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text('Change'))
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(),
                      Text(
                        shippingAddress.name,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text('Phone: ${shippingAddress.phone}'),
                      Text('Email: ${shippingAddress.email}'),
                      Text(
                        'Address: ${shippingAddress.address}, ${shippingAddress.city}, ${shippingAddress.state}, ${shippingAddress.pincode}',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  AppBar buildAppBar(CheckoutPageState state, context) {
    return AppBar(
      title: Text('Checkout'),
      actions: [
        FilledButton(
          onPressed: () async {
            setState(() {});
            BlocProvider.of<CheckoutPageBloc>(context).add(ConfirmCheckout());
            // if (state is CheckOutPageLoadingStatus &&
            //     !state.isLoading &&
            //     !state.isError) {
            Navigator.pushNamed(context, '/payment-page');
            // }
          },
          style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text('Continue'),
        ),
        Gap(20)
      ],
    );
  }
}
