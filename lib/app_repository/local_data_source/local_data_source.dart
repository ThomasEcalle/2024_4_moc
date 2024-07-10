import '../../models/product.dart';

abstract class LocalDataSource {
  Future<void> saveAllProducts(List<Product> products);

  Future<List<Product>> getAllProducts();
}
