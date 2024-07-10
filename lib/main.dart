import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moc_4_2924/app_repository/app_repository.dart';
import 'package:moc_4_2924/app_repository/local_data_source/fake_local_data_source.dart';
import 'package:moc_4_2924/app_repository/remote_data_source/fake_data_source.dart';
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
    return RepositoryProvider(
      create: (context) => AppRepository(
        remoteDataSource: FakeDataSource(),
        localDataSource: FakeLocalDataSource(),
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ProductsBloc(
              appRepository: context.read<AppRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => CartBloc(
              appRepository: context.read<AppRepository>(),
            ),
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
      ),
    );
  }
}
