// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moc_4_2924/app_repository/app_repository.dart';
import 'package:moc_4_2924/app_repository/local_data_source/fake_local_data_source.dart';
import 'package:moc_4_2924/app_repository/local_data_source/local_data_source.dart';
import 'package:moc_4_2924/app_repository/remote_data_source/fake_data_source.dart';
import 'package:moc_4_2924/app_repository/remote_data_source/remote_data_source.dart';
import 'package:moc_4_2924/models/product.dart';
import 'package:moc_4_2924/products_screen/cart_bloc/cart_bloc.dart';
import 'package:moc_4_2924/products_screen/products_bloc/products_bloc.dart';
import 'package:moc_4_2924/products_screen/products_screen.dart';

class ErrorLocalDataSource extends LocalDataSource {
  @override
  Future<List<Product>> getAllProducts() {
    throw Error();
  }

  @override
  Future<void> saveAllProducts(List<Product> products) {
    throw Error();
  }
}

class ErrorDataSource extends RemoteDataSource {
  @override
  Future<void> addProductToCart(Product product) {
    throw Error();
  }

  @override
  Future<List<Product>> getAllProducts() async {
    await Future.delayed(const Duration(seconds: 2));
    throw Error();
  }

  @override
  Future<void> removeProductFromCart(Product product) {
    throw Error();
  }
}

class EmptyDataSource extends RemoteDataSource {
  @override
  Future<void> addProductToCart(Product product) {
    throw Error();
  }

  @override
  Future<List<Product>> getAllProducts() async {
    await Future.delayed(const Duration(seconds: 2));
    return [];
  }

  @override
  Future<void> removeProductFromCart(Product product) {
    throw Error();
  }
}

Widget _buildProductsScreen({
  RemoteDataSource? remoteDataSource,
  LocalDataSource? localDataSource,
}) {
  return RepositoryProvider(
    create: (context) => AppRepository(
      remoteDataSource: remoteDataSource ?? FakeDataSource(),
      localDataSource: localDataSource ?? FakeLocalDataSource(),
    ),
    child: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CartBloc(
            appRepository: context.read<AppRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => ProductsBloc(
            appRepository: context.read<AppRepository>(),
          ),
        ),
      ],
      child: const MaterialApp(
        home: ProductsScreen(),
      ),
    ),
  );
}

void main() {
  group('$ProductsScreen', () {
    testWidgets('Title should be "Products"', (WidgetTester tester) async {
      await tester.pumpWidget(_buildProductsScreen());
      expect(find.text('Products'), findsOneWidget);
      await tester.pumpAndSettle();
    });

    testWidgets('A CircularProgressIndicator should be visible when loading', (WidgetTester tester) async {
      await tester.pumpWidget(_buildProductsScreen());
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pumpAndSettle();
    });

    testWidgets('An appropriate error message should be visible on error', (WidgetTester tester) async {
      await tester.pumpWidget(_buildProductsScreen(
        remoteDataSource: ErrorDataSource(),
        localDataSource: ErrorLocalDataSource(),
      ));
      await tester.pumpAndSettle();
      expect(find.text('Oups, une erreur est suvenue'), findsOneWidget);
      await tester.pumpAndSettle();
    });

    testWidgets('An appropriate message should be visible when products list is empty', (WidgetTester tester) async {
      await tester.pumpWidget(_buildProductsScreen(
        remoteDataSource: EmptyDataSource(),
        localDataSource: FakeLocalDataSource(),
      ));

      await tester.pumpAndSettle();
      expect(find.text('Oups, aucun produit'), findsOneWidget);
      await tester.pumpAndSettle();
    });
  });
}
