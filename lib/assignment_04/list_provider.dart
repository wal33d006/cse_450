import 'package:cse_450/assignment_04/task.dart';
import 'package:flutter/foundation.dart';

class ListProvider extends ChangeNotifier {
  final List<Task> _list = [Task(title: 'Hello')];

  List<Task> get list => _list;

  void addTask(Task task) {
    _list.add(task);
    notifyListeners();
  }

  void markAsDone(Task task) {
    task.isDone = true;
    notifyListeners();
  }
}
