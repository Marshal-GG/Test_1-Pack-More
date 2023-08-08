import 'package:flutter/foundation.dart';

class DrawerSelectionState extends ChangeNotifier {
  late String _selectedItem = 'Home';

  String get selectedItem => _selectedItem;

  void setSelectedItem(String item) {
    _selectedItem = item;
    notifyListeners();
  }
}
