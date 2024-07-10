import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:moc_4_2924/app_repository/remote_data_source/remote_data_source.dart';
import 'package:moc_4_2924/models/product.dart';

class ApiDataSource extends RemoteDataSource {
  @override
  Future<List<Product>> getAllProducts() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/products'));
    if (response.statusCode != 200) throw Exception('Failed to load products');
    final List<dynamic> productsData = json.decode(response.body)['products'];

    return productsData.map((product) => Product.fromJson(product)).toList();
  }

  @override
  Future<void> addProductToCart(Product product) {
    // TODO: implement addProductToCart
    throw UnimplementedError();
  }

  @override
  Future<void> removeProductFromCart(Product product) {
    // TODO: implement removeProductFomCart
    throw UnimplementedError();
  }
}
