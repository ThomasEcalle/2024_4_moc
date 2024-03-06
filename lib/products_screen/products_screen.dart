import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
      final response = await http.get(Uri.parse('https://dummyjson.com/products'));
      if (response.statusCode != 200) throw Exception('Failed to load products');
      final List<dynamic> productsData = json.decode(response.body)['products'];
      _products.clear();

      _products.addAll(productsData.map((product) => Product.fromJson(product)).toList());
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
    if(_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if(_error != null) {
      return Center(
        child: Text('Error: $_error'),
      );
    }

    if(_products.isEmpty) {
      return const Center(
        child: Text('No products found'),
      );
    }

    return ListView.builder(
      itemCount: _products.length,
      itemBuilder: (context, index) {
        final product = _products[index];
        return ListTile(
          title: Text(product.name),
          subtitle: Text(product.price.toString()),
        );
      },
    );
  }
}
