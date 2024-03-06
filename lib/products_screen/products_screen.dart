import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moc_4_2924/products_screen/product_detail_screen/product_detail_screen.dart';
import 'package:moc_4_2924/products_screen/product_item.dart';
import 'package:moc_4_2924/products_screen/products_bloc/products_bloc.dart';
import 'package:moc_4_2924/webservices.dart';

import '../models/product.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    super.initState();
    _getAllProducts();
  }

  void _getAllProducts() async {
    final productsBloc = BlocProvider.of<ProductsBloc>(context);
    productsBloc.add(GetAllProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          final products = state.products;

          if(state.status == ProductsStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductItem(
                product: product,
                onTap: () => _onProductTap(product),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: _getAllProducts,
      ),
    );
  }

  void _onProductTap(Product product) {
    ProductDetailScreen.navigateTo(context, product);
  }
}
