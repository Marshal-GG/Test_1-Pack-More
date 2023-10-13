part of 'home_page_bloc.dart';

sealed class HomePageState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class HomePageInitial extends HomePageState {
  final List<Map<String, dynamic>> categories;
  final int selectedIndex;
  final List<Products> products;

  HomePageInitial({
    required this.categories,
    required this.selectedIndex,
    required this.products,
  });

  HomePageInitial copyWith({
    List<Map<String, dynamic>>? categories,
    int? selectedIndex,
    List<Products>? products,
  }) {
    return HomePageInitial(
      categories: categories ?? this.categories,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      products: products ?? this.products,
    );
  }

  @override
  List<Object> get props => [categories, selectedIndex, products];
}