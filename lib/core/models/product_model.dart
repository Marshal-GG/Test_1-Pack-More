import '../firebase/firebase_services.dart';

FirebaseService firebaseService = FirebaseService();

class Products {
  String? imageUrl;
  void setImageUrl(String url) {
    imageUrl = url;
  }

  Future<void> updateImageUrl(String url) async {
    imageUrl = await firebaseService.getDownloadUrl(url);
  }

  final int id;

  // final String imageUrl;
  final String name;
  final String category;
  final String description;
  final int quantity;
  final int price;

  Products({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.quantity,
    required this.price,
  });
}
