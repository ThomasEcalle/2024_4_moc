import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moc_4_2924/models/app_exception.dart';
import 'package:moc_4_2924/models/product.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<AddProduct>(_onAddProduct);
    on<RemoveProduct>(_onRemoveProduct);
  }

  void _onAddProduct(AddProduct event, Emitter<CartState> emit) async {
    emit(state.copyWith(status: CartStatus.addingProduct));
    final product = event.product;
    await Future.delayed(const Duration(seconds: 1));

    if (product.id == 6) {
      emit(state.copyWith(
        status: CartStatus.errorAddingProduct,
        error: ProductNotAvailableAnymoreException(),
      ));
    } else {
      emit(state.copyWith(
        status: CartStatus.addedProductWithSuccess,
        products: [...state.products, product],
      ));
    }
  }

  void _onRemoveProduct(RemoveProduct event, Emitter<CartState> emit) async {
    emit(state.copyWith(status: CartStatus.removingProduct));
    final product = event.product;
    await Future.delayed(const Duration(seconds: 1));
    /// Remove first occurrence of product

    emit(state.copyWith(
      status: CartStatus.removedProductWithSuccess,
      products: List.from(state.products)..remove(product),
    ));
  }
}
