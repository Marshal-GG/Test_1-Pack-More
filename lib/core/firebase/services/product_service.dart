import 'firebase_services.dart';
import '../../models/product_model.dart';

class ProductsService {
  Future<List<Products>> fetchProductImageUrls(
      List<Products> products, FirebaseService firebaseService) async {
    List<Products> updatedProducts = [];
    for (var product in products) {
      if (product.imageUrl != null) {
        String? imageUrl =
            await firebaseService.getDownloadUrl(product.imageUrl!);
        Products updatedProduct = product.copyWith(imageUrl: imageUrl);
        updatedProducts.add(updatedProduct);
        // product.imageUrl = imageUrl;
      } else {
        updatedProducts.add(product);
      }
    }
    return updatedProducts;
  }
}
