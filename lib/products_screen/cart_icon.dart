import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moc_4_2924/products_screen/cart_bloc/cart_bloc.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          final productsCount = state.products.length;
          return Row(
            children: [
              const Icon(Icons.shopping_cart),
              Text('($productsCount)'),
            ],
          );
        },
      ),
    );
  }
}
