import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moc_4_2924/models/product.dart';
import 'package:moc_4_2924/products_screen/cart_bloc/cart_bloc.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.product,
    this.onTap,
  });

  final Product product;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name),
      subtitle: Text('Prix: ${product.price}'),
      trailing: BlocBuilder<CartBloc, CartState>(
        buildWhen: (previousState, nextState) {
          final hasCartSizeChanged = previousState.products.length != nextState.products.length;
          final previousOccurrences = previousState.products.where((element) => element.id == product.id).length;
          final nextOccurrences = nextState.products.where((element) => element.id == product.id).length;
          if(!hasCartSizeChanged) return false;
          if(previousOccurrences == nextOccurrences) return false;
          return true;
        },
        builder: (context, state) {
          print('Building ${product.id} product');
          final occurrences = state.products.where((element) => element.id == product.id).length;
          if (occurrences == 0) return const SizedBox();
          return Text('$occurrences dans panier');
        },
      ),
      onTap: onTap,
    );
  }
}
