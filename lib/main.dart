import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moc_4_2924/models/product.dart';
import 'package:moc_4_2924/products_screen/product_detail_screen/product_detail_screen.dart';
import 'package:moc_4_2924/products_screen/products_bloc/products_bloc.dart';
import 'package:moc_4_2924/products_screen/products_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsBloc(),
      child: MaterialApp(
        home: const ProductsScreen(),
        onGenerateRoute: (settings) {
          Widget content = const SizedBox();

          switch (settings.name) {
            case ProductDetailScreen.routeName:
              final arguments = settings.arguments;
              if (arguments is Product) {
                content = ProductDetailScreen(product: arguments);
              }
              break;
          }

          return MaterialPageRoute(builder: (context) => content);
        },
      ),
    );
  }
}
