part of 'home_page_bloc.dart';

abstract class HomePageEvent {}

class FetchCategoriesEvent extends HomePageEvent {
  final int newIndex;
  FetchCategoriesEvent(this.newIndex);
}

class FetchProductsByCategoryEvent extends HomePageEvent {
  final String selectedCategoryName;

  FetchProductsByCategoryEvent(this.selectedCategoryName);
}

class FetchImageUrlsEvent extends HomePageEvent {
  final List<Products> products;

  FetchImageUrlsEvent(
    this.products,
  );
}