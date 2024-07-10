import 'package:moc_4_2924/app_repository/local_data_source/local_data_source.dart';
import 'package:moc_4_2924/models/product.dart';

class FakeLocalDataSource extends LocalDataSource {
  List<Product> products = [];

  @override
  Future<List<Product>> getAllProducts() async {
    await Future.delayed(const Duration(seconds: 1));
    return products;
  }

  @override
  Future<void> saveAllProducts(List<Product> products) async {
    await Future.delayed(const Duration(seconds: 1));
    this.products = products;
  }
}
