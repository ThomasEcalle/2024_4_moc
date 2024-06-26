import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String name;
  final String description;
  final double price;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['title'],
      description: json['description'],
      price: json['price'].toDouble(),
    );
  }

  @override
  List<Object?> get props => [id];
}
