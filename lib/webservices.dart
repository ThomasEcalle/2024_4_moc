import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:moc_4_2924/models/product.dart';

class WebServices {
  static Future<List<Product>> getAllProducts() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/products'));
    if (response.statusCode != 200) throw Exception('Failed to load products');
    final List<dynamic> productsData = json.decode(response.body)['products'];

    return productsData.map((product) => Product.fromJson(product)).toList();
  }
}
