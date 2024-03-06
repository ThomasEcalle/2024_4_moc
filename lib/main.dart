import 'package:flutter/material.dart';
import 'package:moc_4_2924/products_screen/products_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ProductsScreen(),
    );
  }
}
