import 'package:flutter/material.dart';

class City {
  int id;
  String name;

  City(int id, String name) : this.id = id, this.name = name;
}

class AppState extends ChangeNotifier {
  String searchText = "";
  Future<List<City>> cities = Future.value([]);

  void changeSearchText(String searchText) {
    this.searchText = searchText;
    notifyListeners();
  }

  void setFuture(Future<List<City>> newFuture) {
    cities = newFuture;
    notifyListeners();
  }
}