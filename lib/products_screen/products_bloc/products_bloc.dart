import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/product.dart';

part 'products_event.dart';

part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(const ProductsState()) {
    on<GetAllProducts>((event, emit) async {
      emit(const ProductsState(status: ProductsStatus.loading));
      final products = await _getAllProducts();
      emit(ProductsState(products: products));
    });
  }

  Future<List<Product>> _getAllProducts() async {
    await Future.delayed(const Duration(seconds: 1));
    return List.generate(10, (index) {
      return Product(
        id: index,
        name: 'Product $index',
        description: 'Description $index',
        price: index.toDouble(),
      );
    });
  }
}
