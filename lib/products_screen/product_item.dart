import 'package:flutter/material.dart';
import 'package:moc_4_2924/models/product.dart';

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
      subtitle: Text(product.price.toString()),
      onTap: onTap,
    );
  }
}
