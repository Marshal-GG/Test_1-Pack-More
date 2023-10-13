import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/models/product_model.dart';
import 'bloc/view_all_products_bloc.dart';

class ViewAllProductsPage extends StatefulWidget {
  ViewAllProductsPage({super.key});

  @override
  State<ViewAllProductsPage> createState() => _ViewAllProductsPageState();
}

class _ViewAllProductsPageState extends State<ViewAllProductsPage> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(scrollListener); 
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      final viewAllProductsBloc = BlocProvider.of<ViewAllProductsBloc>(context);
      viewAllProductsBloc.add(ScrollListenerEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('All Products')),
      body: BlocBuilder<ViewAllProductsBloc, ViewAllProductsState>(
        builder: (context, state) {
          if (state is ViewAllProductsInitial) {
            final products = state.products;
            return buildBody(context, products);
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Padding buildBody(BuildContext context, List<Products> products) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        controller: scrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 3,
          crossAxisSpacing: 3,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 1.45),
        ),
        itemCount: products.isNotEmpty ? products.length + 1 : 0,
        itemBuilder: (context, index) {
          if (index < products.length) {
            return ProductCard(products[index]);
          }
          return null;
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Products product;

  ProductCard(this.product);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/product-details-page',
          arguments: product,
        );
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 8),
              buildImage(),
              SizedBox(height: 8),
              Text(
                product.name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.tertiary,
                ),
              ),
              SizedBox(height: 4),
              Text(
                '₹ ${product.price}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.error,
                ),
              ),
              SizedBox(height: 8),
              // Add more details or buttons as needed
            ],
          ),
        ),
      ),
    );
  }

  AspectRatio buildImage() {
    return AspectRatio(
      aspectRatio: 1,
      child: Hero(
        tag: product.name,
        child: CachedNetworkImage(
          imageUrl: product.imageUrl!,
          fit: BoxFit.contain,
          errorWidget: (context, url, error) =>
              Center(child: CircularProgressIndicator.adaptive()),
        ),
      ),
    );
  }
}
