import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moc_4_2924/models/app_exception.dart';
import 'package:moc_4_2924/models/product.dart';

import '../../app_repository/app_repository.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final AppRepository appRepository;

  CartBloc({required this.appRepository}) : super(const CartState()) {
    on<AddProduct>(_onAddProduct);
    on<RemoveProduct>(_onRemoveProduct);
  }

  void _onAddProduct(AddProduct event, Emitter<CartState> emit) async {
    emit(state.copyWith(status: CartStatus.addingProduct));
    final product = event.product;
    try {
      await appRepository.addProductToCart(product);
      emit(state.copyWith(
        status: CartStatus.addedProductWithSuccess,
        products: [...state.products, product],
      ));
    } catch (error) {
      emit(state.copyWith(status: CartStatus.errorAddingProduct, error: error as AppException));
    }
  }

  void _onRemoveProduct(RemoveProduct event, Emitter<CartState> emit) async {
    emit(state.copyWith(status: CartStatus.removingProduct));
    final product = event.product;

    try {
      await appRepository.removeProductFromCart(product);
      emit(state.copyWith(
        status: CartStatus.removedProductWithSuccess,
        products: List.from(state.products)..remove(product),
      ));
    } catch (error) {
      emit(state.copyWith(status: CartStatus.errorAddingProduct, error: UnknownException()));
    }
  }
}
