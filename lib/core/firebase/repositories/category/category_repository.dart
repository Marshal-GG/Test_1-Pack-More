import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_1/core/firebase/repositories/category/base_category_repo.dart';
import 'package:test_1/core/models/category_model.dart';

class CategoryRepository extends BaseCategoryRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<List<Category>> fetchAllCategories() async {
    final querySnapshot =
        await _firebaseFirestore.collection('categories').get();

    final categories =
        querySnapshot.docs.map((doc) => Category.fromDocument(doc)).toList();

    return categories;
  }
}
