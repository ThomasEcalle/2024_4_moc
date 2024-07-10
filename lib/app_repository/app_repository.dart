import 'package:moc_4_2924/app_repository/local_data_source/local_data_source.dart';
import 'package:moc_4_2924/app_repository/remote_data_source/remote_data_source.dart';

import '../models/product.dart';

class AppRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  AppRepository({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  Future<List<Product>> getAllProducts() async {
    try {
      final products = await remoteDataSource.getAllProducts();
      await localDataSource.saveAllProducts(products);
      return products;
    } catch(error) {
      return localDataSource.getAllProducts();
    }
  }

  Future<void> addProductToCart(Product product) async {
    return remoteDataSource.addProductToCart(product);
  }

  Future<void> removeProductFromCart(Product product) async {
    return remoteDataSource.removeProductFromCart(product);
  }
}
