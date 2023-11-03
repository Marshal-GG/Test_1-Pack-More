part of 'home_page_bloc.dart';

sealed class HomePageState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class HomePageInitial extends HomePageState {}

class HomePageLoaded extends HomePageState {
  final List<Category> categories;
  final int selectedIndex;
  final List<Products> products;

  HomePageLoaded({
    required this.categories,
    required this.selectedIndex,
    required this.products,
  });

  HomePageLoaded copyWith({
    List<Category>? categories,
    int? selectedIndex,
    List<Products>? products,
  }) {
    return HomePageLoaded(
      categories: categories ?? this.categories,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      products: products ?? this.products,
    );
  }

  @override
  List<Object> get props => [categories, selectedIndex, products];
}
