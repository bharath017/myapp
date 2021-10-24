import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:myapp/models/Child1.dart';

class ChildModel extends ChangeNotifier {
  final List<Child1> _items = [];
  late Child1 _catalog;
  // UnmodifiableListView<Child1> get items => UnmodifiableListView(_items);

  void add(Child1 item) {
    _items.add(item);
    print("here");
    print(_items[0]);
    // This line tells [Model] that it should rebuild the widgets that
    // depend on it.
    notifyListeners();
  }

  /// Get item by [id].
  List<Child1> get items => _items.map((id) => _catalog.getById(id)).toList();

  void remove(Child1 item) {
    _items.remove(item);
    // Don't forget to tell dependent widgets to rebuild _every time_
    // you change the model.
    notifyListeners();
  }

  Child1 get catalog => _catalog;
  set catalog(Child1 newCatalog) {
    _catalog = newCatalog;
    // Notify listeners, in case the new catalog provides information
    // different from the previous one. For example, availability of an item
    // might have changed.
    notifyListeners();
  }
}
