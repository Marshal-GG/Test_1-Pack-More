import 'package:equatable/equatable.dart';

class SellerProducts extends Equatable {
  final String id;
  final String name;
  final double price;
  final String description;
  final String category;
  final String status;
  final int quantity;
  late final List<String> imageUrls;

  SellerProducts({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.category,
    required this.status,
    required this.quantity,
    required this.imageUrls,
  });

  SellerProducts copyWith({
    String? id,
    String? name,
    double? price,
    String? description,
    String? category,
    String? status,
    int? quantity,
    List<String>? imageUrls,
  }) {
    return SellerProducts(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      category: category ?? this.category,
      status: status ?? this.status,
      quantity: quantity ?? this.quantity,
      imageUrls: imageUrls ?? this.imageUrls,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        price,
        description,
        category,
        status,
        quantity,
        imageUrls,
      ];
}
