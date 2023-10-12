part of 'home_page_bloc.dart';

class HomePageState {
  final int selectedIndex;
  final List<Map<String, dynamic>> categories;
  final List<Products> products;
  final String selectedCategoryName;

  HomePageState({
    required this.selectedIndex,
    required this.categories,
    required this.products,
    required this.selectedCategoryName,
  });

  HomePageState copyWith({
    int? selectedIndex,
    List<Map<String, dynamic>>? categories,
    List<Products>? products,
    String? selectedCategoryName,
  }) {
    return HomePageState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      categories: categories ?? this.categories,
      products: products ?? this.products,
      selectedCategoryName: selectedCategoryName ?? this.selectedCategoryName,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomePageState &&
          runtimeType == other.runtimeType &&
          selectedIndex == other.selectedIndex &&
          listEquals(categories, other.categories) &&
          listEquals(products, other.products) &&
          selectedCategoryName == other.selectedCategoryName;

  @override
  int get hashCode =>
      selectedIndex.hashCode ^
      categories.hashCode ^
      products.hashCode ^
      selectedCategoryName.hashCode;

  // Helper function to compare lists.
  bool listEquals(List<dynamic> a, List<dynamic> b) {
    if (identical(a, b)) return true;
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
