import 'package:moc_4_2924/models/product.dart';

abstract class RemoteDataSource {
  Future<List<Product>> getAllProducts();

  Future<void> addProductToCart(Product product);

  Future<void> removeProductFromCart(Product product);
}
