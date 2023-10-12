import 'package:bloc/bloc.dart';

class CategorySelectionBloc extends Bloc<int, int> {
  CategorySelectionBloc() : super(0);
  void selectCategory(int newIndex) {
    add(newIndex);
  }

  Stream<int> mapEventToState(int event) async* {
    yield event;
  }
}
