import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryService {
  Future<List<Map<String, dynamic>>> fetchCategories() async {
    try {
      final QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('categories').get();

      final List<Map<String, dynamic>> categories = querySnapshot.docs
          .map((doc) => {
                'id': doc['id'] as int,
                'name': doc['name'] as String,
                'img': doc['img'] as String
              })
          .toList();

      return categories;
    } catch (e) {
      throw Exception('Error fetching categories: $e');
    }
  }
  
}
