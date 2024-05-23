import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moc_4_2924/products_screen/cart_bloc/cart_bloc.dart';

extension BuildContextExtensions on BuildContext {
  CartBloc get cartBloc => read<CartBloc>();
}
