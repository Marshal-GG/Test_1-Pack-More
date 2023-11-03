import '../../../models/models.dart';

abstract class BaseCategoryRepository {
  Future<List<Category>> fetchAllCategories();
}
