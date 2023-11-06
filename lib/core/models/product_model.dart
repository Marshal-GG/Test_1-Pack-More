import 'package:equatable/equatable.dart';

class Products extends Equatable {
  final int id;
  final String name;
  final String category;
  final String description;
  final String imageUrl;
  final int quantity;
  final int price;
  final String productID;

  Products({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.quantity,
    required this.price,
    required this.productID,
  });

  Products copyWith({
    int? id,
    String? name,
    String? category,
    String? description,
    String? imageUrl,
    int? quantity,
    int? price,
    String? productID,
  }) {
    return Products(
        id: id ?? this.id,
        name: name ?? this.name,
        category: category ?? this.category,
        description: description ?? this.description,
        imageUrl: imageUrl ?? this.imageUrl,
        quantity: quantity ?? this.quantity,
        price: price ?? this.price,
        productID: productID ?? this.productID);
  }

  static Products fromDocument(data) {
    Products product = Products(
      id: data['id'],
      name: data['name'],
      category: data['category'],
      description: data['description'],
      imageUrl: data['image_Url'],
      quantity: data['quantity'],
      price: data['price'],
      productID: data['productID'],
    );
    return product;
  }

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'description': description,
      'image_Url': imageUrl,
      'quantity': quantity,
      'price': price,
      'productID': productID,
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        category,
        description,
        imageUrl,
        quantity,
        price,
        productID,
      ];
}
