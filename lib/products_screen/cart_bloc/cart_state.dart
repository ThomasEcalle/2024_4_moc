part of 'cart_bloc.dart';

enum CartStatus {
  initial,
  addingProduct,
  addedProductWithSuccess,
  errorAddingProduct,
  removingProduct,
  removedProductWithSuccess,
  errorRemovingProduct,
}

class CartState {
  final CartStatus status;
  final List<Product> products;
  final AppException? error;

  const CartState({
    this.status = CartStatus.initial,
    this.products = const [],
    this.error,
  });

  CartState copyWith({
    CartStatus? status,
    List<Product>? products,
    AppException? error,
  }) {
    return CartState(
      status: status ?? this.status,
      products: products ?? this.products,
      error: error ?? this.error,
    );
  }
}
