import 'package:moc_4_2924/app_repository/remote_data_source/remote_data_source.dart';
import 'package:moc_4_2924/models/app_exception.dart';
import 'package:moc_4_2924/models/product.dart';

class FakeDataSource extends RemoteDataSource {
  @override
  Future<List<Product>> getAllProducts() async {
    await Future.delayed(const Duration(seconds: 1));
    return List.generate(4, (index) {
      return Product(
        id: index,
        name: 'name $index',
        description: 'description $index',
        price: 3.0 + index,
      );
    });
  }

  @override
  Future<void> addProductToCart(Product product) async {
    await Future.delayed(const Duration(seconds: 1));
    if (product.id == 0) throw ProductNotAvailableAnymoreException();
    return;
  }

  @override
  Future<void> removeProductFromCart(Product product) async {
    await Future.delayed(const Duration(seconds: 1));
    return;
  }
}
