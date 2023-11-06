import 'package:flutter/services.dart';

import '../../core/routes/routes_config.dart';
import 'package:test_1/core/models/order_details_model.dart';
import 'package:test_1/core/models/product_model.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  void initState() {
    BlocProvider.of<OrdersPageBloc>(context).add(LoadOrdersPageEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<OrdersPageBloc, OrdersPageState>(
      builder: (context, state) {
        if (state is OrdersPageLoadingStatusState && state.orders.isNotEmpty) {
          final orders = state.orders;
          return buildBody(orders, colorScheme);
        } else if (state is OrdersPageLoadingStatusState &&
            state.orders.isEmpty) {
          return Scaffold(
              appBar: AppBar(title: Text('My Orders')),
              body:
                  Center(child: Text('''You don't have any orders yet !!''')));
        } else {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Scaffold buildBody(List<OrderDetails> orders, ColorScheme colorScheme) {
    return Scaffold(
      appBar: AppBar(title: Text('My Orders')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            buildOrdersList(orders, colorScheme),
          ],
        ),
      ),
    );
  }

  SliverList buildOrdersList(
      List<OrderDetails> orders, ColorScheme colorScheme) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: orders.length,
        (context, index) {
          if (index < orders.length) {
            final order = orders[index];
            final products = order.products;
            return Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 2,
              child: Column(
                children: [
                  buildProductsList(products, colorScheme),
                  Divider(),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Order ID: ${order.orderId}',
                          style: TextStyle(
                            color: colorScheme.onBackground.withOpacity(0.5),
                            fontSize: 14,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Clipboard.setData(
                                ClipboardData(text: order.orderId));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Order ID copied to clipboard'),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.content_copy,
                            size: 24,
                            color: colorScheme.onBackground.withOpacity(0.5),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return null;
        },
      ),
    );
  }

  ListView buildProductsList(List<Products> products, ColorScheme colorScheme) {
    return ListView.builder(
      itemCount: products.length,
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context, index) {
        if (index < products.length) {
          final product = products[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image(
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(product.imageUrl),
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(fontSize: 16),
                    maxLines: 2,
                  ),
                  Gap(3),
                  Row(
                    children: [
                      Text(
                        '₹ ${product.price}',
                        style: TextStyle(color: colorScheme.primary),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
        return null;
      },
    );
  }
}
