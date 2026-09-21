import 'package:edencrew_assignment_starter/views/searchlist_screen/index.dart';
import 'package:edencrew_assignment_starter/views/watchlist_screen/index.dart';
import 'package:flutter/cupertino.dart';

class MainViewModel extends ChangeNotifier {
  int _selectIndex = 0;

  int get selectIndex => _selectIndex;

  final List<Widget> widgetOptions = const [
    WatchlistScreen(),
    SearchlistScreen(),
  ];

  void onItemTapped(int index) {
    if (_selectIndex != index) {
      _selectIndex = index;
      notifyListeners();
    }
  }
}
