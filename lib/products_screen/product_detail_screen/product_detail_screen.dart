import 'package:flutter/material.dart';
import 'package:moc_4_2924/models/product.dart';

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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_shopping_cart),
        onPressed: () => _onAddToCartTap(context),
      ),
    );
  }

  void _onAddToCartTap(BuildContext context) {

  }
}
