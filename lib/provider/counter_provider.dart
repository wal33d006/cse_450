import 'package:flutter/cupertino.dart';

class CounterProvider extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  // set count(int value) => _count = value;

  void increment() {
    _count++;
    notifyListeners();
  }
}
