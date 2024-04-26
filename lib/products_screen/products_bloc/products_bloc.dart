import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moc_4_2924/models/app_exception.dart';

import '../../models/product.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(const ProductsState()) {
    on<GetAllProducts>(_onGetAllProducts);
  }

  void _onGetAllProducts(GetAllProducts event, Emitter<ProductsState> emit) async {
    emit(state.copyWith(status: ProductsStatus.loading));
    try {
      final products = await _getAllProducts();
      emit(state.copyWith(
        status: ProductsStatus.success,
        products: products,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: ProductsStatus.error,
        error: UnknownException(),
      ));
    }
  }

  Future<List<Product>> _getAllProducts() async {
    await Future.delayed(const Duration(seconds: 2));
    throw Exception();
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
