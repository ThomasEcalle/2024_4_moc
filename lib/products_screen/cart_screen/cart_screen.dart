import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moc_4_2924/products_screen/cart_bloc/cart_bloc.dart';
import 'package:moc_4_2924/products_screen/product_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = 'cartScreen';

  static Future<void> navigateTo(BuildContext context) {
    return Navigator.of(context).pushNamed(routeName);
  }

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon panier'),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          final products = state.products;
          return ListView.separated(
            itemCount: products.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductItem(product: product);
            },
          );
        },
      ),
    );
  }
}
