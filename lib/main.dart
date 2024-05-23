import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moc_4_2924/models/product.dart';
import 'package:moc_4_2924/products_screen/cart_bloc/cart_bloc.dart';
import 'package:moc_4_2924/products_screen/cart_screen/cart_screen.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductsBloc(),
        ),
        BlocProvider(
          create: (context) => CartBloc(),
        ),
      ],
      child: MaterialApp(
        home: const ProductsScreen(),
        routes: {
          CartScreen.routeName: (context) => const CartScreen(),
        },
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
