import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../core/models/models.dart';
import '../../address_details_page/bloc/address_details_page_bloc.dart';
import 'bloc/check_out_page_bloc.dart';

class CheckoutPage extends StatefulWidget {
  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool hasEmptyData = true;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<CheckoutPageBloc, CheckoutPageState>(
      builder: (context, state) {
        return Scaffold(
          appBar: buildAppBar(),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                buildAddressCard(context, colorScheme),
                Spacer(),
                buildPriceDetailsCard(),
              ],
            ),
          ),
        );
      },
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
                  onTap: () {
                    Navigator.pushNamed(context, '/address-details-page');
                  },
                  title: Row(
                    children: [
                      Text(
                        'Shipping Address',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gap(10),
                      Icon(
                        Icons.edit_outlined,
                        color: colorScheme.primary,
                      ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(),
                      Text(
                        'Name: ${shippingAddress.name}',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Gap(5),
                      Text('Phone: ${shippingAddress.phone}'),
                      Gap(5),
                      Text('Email: ${shippingAddress.email}'),
                      Gap(5),
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

  AppBar buildAppBar() {
    return AppBar(
      title: Text('Checkout'),
      actions: [
        FilledButton(
          onPressed: () {
            setState(() {});
          },
          style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text('Save'),
        ),
        Gap(20)
      ],
    );
  }
}
