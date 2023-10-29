import 'package:equatable/equatable.dart';

import '../firebase/services/firebase_services.dart';

class Products extends Equatable {
  final int id;
  final String name;
  final String category;
  final String description;
  final String imageUrl;
  final int quantity;
  final int price;
  final String productID;
  final FirebaseService firebaseService = FirebaseService();

  Products({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.quantity,
    required this.price,
    required this.productID
  });

  // Future<void> updateImageUrl(String url) async {
  //   try {
  //     imageUrl = await firebaseService.getDownloadUrl(url);
  //   } catch (e) {
  //     print('Failed to update image URL: $e');
  //   }
  // }

  // void setImageUrl(String url) {
  //   imageUrl = url;
  // }

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
      productID: productID ?? this.productID
    );
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
        firebaseService,
      ];
}
