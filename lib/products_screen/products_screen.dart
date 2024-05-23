import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moc_4_2924/products_screen/cart_bloc/cart_bloc.dart';
import 'package:moc_4_2924/products_screen/cart_icon.dart';
import 'package:moc_4_2924/products_screen/cart_screen/cart_screen.dart';
import 'package:moc_4_2924/products_screen/product_detail_screen/product_detail_screen.dart';
import 'package:moc_4_2924/products_screen/product_item.dart';
import 'package:moc_4_2924/products_screen/products_bloc/products_bloc.dart';

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
    return BlocListener<CartBloc, CartState>(
      listener: _onCartBlocListener,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Products'),
          actions: [
            CartIcon(
              onTap: () => _onCartIconTap(context),
            ),
          ],
        ),
        body: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            final products = state.products;

            if (state.status == ProductsStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state.status == ProductsStatus.error) {
              return const Center(
                child: Text('Oups, une erreur est suvenue'),
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
          onPressed: _getAllProducts,
          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }

  void _onProductTap(Product product) {
    ProductDetailScreen.navigateTo(context, product);
  }

  void _onCartIconTap(BuildContext context) {
    CartScreen.navigateTo(context);
  }

  void _onCartBlocListener(BuildContext context, CartState state) {
    if (state.status == CartStatus.errorAddingProduct) {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            icon: Icon(Icons.error),
            title: Text('oups une erreur est survenue'),
          );
        },
      );
    }
  }
}
