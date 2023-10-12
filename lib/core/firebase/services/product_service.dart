import '../firebase_services.dart';
import '../../models/product_model.dart';

class ProductsService {
  Future<void> fetchProductImageUrls(
      List<Products> products, FirebaseService firebaseService) async {
    for (var product in products) {
      if (product.imageUrl != null) {
        String? imageUrl =
            await firebaseService.getDownloadUrl(product.imageUrl!);
        product.setImageUrl(imageUrl);
      }
    }
  }
}
