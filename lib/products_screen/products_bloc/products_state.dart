part of 'products_bloc.dart';

enum ProductsStatus {
  loading,
  success,
  error,
}

class ProductsState {
  final ProductsStatus status;
  final List<Product> products;
  final AppException? error;

  const ProductsState({
    this.status = ProductsStatus.loading,
    this.products = const [],
    this.error,
  });

  ProductsState copyWith({
    ProductsStatus? status,
    List<Product>? products,
    AppException? error,
  }) {
    return ProductsState(
      status: status ?? this.status,
      products: products ?? this.products,
      error: error ?? this.error,
    );
  }
}
