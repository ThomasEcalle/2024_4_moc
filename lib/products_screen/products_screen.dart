import 'package:flutter/material.dart';
import 'package:moc_4_2924/products_screen/product_detail_screen/product_detail_screen.dart';
import 'package:moc_4_2924/products_screen/product_item.dart';
import 'package:moc_4_2924/webservices.dart';

import '../models/product.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final List<Product> _products = [];
  String? _error;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getAllProducts();
  }

  void _getAllProducts() async {
    try {
      final products = await WebServices.getAllProducts();
      _products.clear();
      _products.addAll(products);
    } catch (error) {
      _error = error.toString();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_error != null) {
      return Center(
        child: Text('Error: $_error'),
      );
    }

    if (_products.isEmpty) {
      return const Center(
        child: Text('No products found'),
      );
    }

    return ListView.builder(
      itemCount: _products.length,
      itemBuilder: (context, index) {
        final product = _products[index];
        return ProductItem(
          product: product,
          onTap: () => _onProductTap(product),
        );
      },
    );
  }

  void _onProductTap(Product product) {
    ProductDetailScreen.navigateTo(context, product);
  }
}
