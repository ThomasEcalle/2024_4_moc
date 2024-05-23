import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moc_4_2924/extension_example/build_context_extensions.dart';
import 'package:moc_4_2924/models/product.dart';
import 'package:moc_4_2924/products_screen/cart_bloc/cart_bloc.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = 'productDetailScreen';

  static Future<void> navigateTo(BuildContext context, Product product) {
    return Navigator.of(context).pushNamed(routeName, arguments: product);
  }

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${product.name}'),
      ),
      floatingActionButton: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {

          final removeButtonContent = switch(state.status) {
            CartStatus.removingProduct => const CircularProgressIndicator(),
            _ => const Icon(Icons.remove),
          };

          final addButtonContent = switch(state.status) {
            CartStatus.addingProduct => const CircularProgressIndicator(),
            _ => const Icon(Icons.add),
          };

          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: 'toto',
                child: removeButtonContent,
                onPressed: () => _onRemoveCartTap(context),
              ),
              const SizedBox(height: 10),
              FloatingActionButton(
                child: addButtonContent,
                onPressed: () => _onAddToCartTap(context),
              ),
            ],
          );
        },
      ),
    );
  }

  void _onAddToCartTap(BuildContext context) {
    // final cartBloc2 = BlocProvider.of<CartBloc>(context);
    // final cartBloc3 = context.read<CartBloc>();
    context.cartBloc.add(AddProduct(product: product));
  }

  void _onRemoveCartTap(BuildContext context) {
    context.cartBloc.add(RemoveProduct(product: product));
  }
}
