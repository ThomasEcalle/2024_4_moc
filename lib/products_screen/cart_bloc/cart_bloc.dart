import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moc_4_2924/models/app_exception.dart';
import 'package:moc_4_2924/models/product.dart';

part 'cart_event.dart';part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<AddProduct>(_onAddProduct);
    on<RemoveProduct>(_onRemoveProduct);
  }

  void _onAddProduct(AddProduct event, Emitter<CartState> emit) async {
    emit(state.copyWith(status: CartStatus.addingProduct));
    await Future.delayed(const Duration(seconds: 3));
    emit(state.copyWith(
      status: CartStatus.addedProductWithSuccess,
      products: [...state.products, event.product],
    ));
  }

  void _onRemoveProduct(RemoveProduct event, Emitter<CartState> emit) async {
    emit(state.copyWith(status: CartStatus.removingProduct));
    await Future.delayed(const Duration(seconds: 1));
    final products = state.products;
    products.removeWhere((element) => element.id == event.product.id);
    emit(state.copyWith(
      status: CartStatus.removedProductWithSuccess,
      products: products,
    ));
  }
}
