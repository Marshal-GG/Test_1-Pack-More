import '../firebase/firebase_services.dart';

class Products {
  final int id;
  final String name;
  final String category;
  final String description;
  String? imageUrl;
  final int quantity;
  final int price;
  final FirebaseService firebaseService = FirebaseService();

  Products({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.quantity,
    required this.price,
  });

  Future<void> updateImageUrl(String url) async {
    try {
      imageUrl = await firebaseService.getDownloadUrl(url);
    } catch (e) {
      print('Failed to update image URL: $e');
    }
  }

  void setImageUrl(String url) {
    imageUrl = url;
  }
}
