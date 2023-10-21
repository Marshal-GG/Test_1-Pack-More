import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/seller_product_model.dart';
import '../../../core/widgets/custom_drawer.dart';
import 'bloc/seller_view_products_page_bloc.dart';

class SellerViewProductsPage extends StatefulWidget {
  @override
  State<SellerViewProductsPage> createState() => _SellerViewProductsPageState();
}

class _SellerViewProductsPageState extends State<SellerViewProductsPage> {
  @override
  void initState() {
    BlocProvider.of<SellerViewProductsPageBloc>(context)
        .add(ReloadProductsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SellerViewProductsPageBloc, SellerViewProductsPageState>(
      builder: (context, state) {
        if (state is SellerViewProductsPageLoaded) {
          final colorScheme = Theme.of(context).colorScheme;
          final products = state.products;
          return Scaffold(
            appBar: AppBar(title: Text('Your Products')),
            drawer: CustomDrawerWidget(),
            body: buildProductsList(colorScheme, products),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, '/add-product-page');
              },
            ),
          );
        } else {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget buildProductsList(
    ColorScheme colorScheme,
    List<SellerProducts> products,
  ) {
    if (products.isEmpty) {
      return Center(
          child: Text('No Data Available', style: TextStyle(fontSize: 24)));
    }
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        if (index < products.length) {
          final SellerProducts product = products[index];
          return ListTile(
            leading: product.imageUrls.isNotEmpty
                ? CircleAvatar(
                    radius: 24,
                    backgroundImage:
                        CachedNetworkImageProvider(product.imageUrls[0]),
                  )
                : CircularProgressIndicator.adaptive(),
            title: Text(product.name),
            subtitle: Text(
              'Price: ₹ ${product.price}',
              style: TextStyle(color: colorScheme.onSurfaceVariant),
            ),
            trailing: Icon(Icons.keyboard_arrow_right, size: 24),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/seller-product-details-page',
                arguments: product,
              );
            },
          );
        }
        return null;
      },
    );
  }
}
