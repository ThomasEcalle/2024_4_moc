import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moc_4_2924/models/app_exception.dart';

import '../../app_repository/app_repository.dart';
import '../../models/product.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final AppRepository appRepository;

  ProductsBloc({required this.appRepository}) : super(const ProductsState()) {
    on<GetAllProducts>(_onGetAllProducts);
  }

  void _onGetAllProducts(GetAllProducts event, Emitter<ProductsState> emit) async {
    emit(state.copyWith(status: ProductsStatus.loading));
    try {
      final products = await appRepository.getAllProducts();
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
}
