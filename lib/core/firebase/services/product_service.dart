// import '../../models/product_model.dart';
// import '../firebase_services.dart';

// class ProductService {
//   Future<void> fetchProductImageUrls(List<Products> products) async {
//     for (var product in products) {
//       if (product.imageUrl != null) {
//         String? imageUrl =
//             await firebaseService.getDownloadUrl(product.imageUrl!);
//         setState(() {
//           product.setImageUrl(imageUrl);
//         });
//       }
//     }
//   }
// }
