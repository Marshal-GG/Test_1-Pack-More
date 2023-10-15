part of 'home_page_bloc.dart';

abstract class HomePageEvent extends Equatable {
  const HomePageEvent();

  @override
  List<Object?> get props => [];
}

class ChangeCategoriesEvent extends HomePageEvent {
  final int newIndex;
  ChangeCategoriesEvent({required this.newIndex});

  @override
  List<Object> get props => [newIndex];
}

class HomePageCounterEvent extends HomePageEvent {}
