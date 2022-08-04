import 'package:flutter/material.dart';
import 'package:flutter_shoe_app/views/application/application_view_model.dart';
import 'package:flutter_shoe_app/views/home/shoe_object.dart';

class SearchPageViewModel extends ChangeNotifier {
  List<Shoe> items = ApplicationViewModel.items;

  //
  List<Shoe> foundShoes = [];

  bool hideResultCount = true;

  bool hasInput = false;

  void initialize() {
    foundShoes = items;
    notifyListeners();
  }

  void onTextChanged(String input) {
    foundShoes = items
        .where((shoe) => shoe.title.toLowerCase().contains(input.toLowerCase()))
        .toList();
    hideResultCount = false;
    hideResultCount = input.isEmpty ? true : false;
    hasInput = input.isEmpty ? false : true;
    notifyListeners();
  }

  final searchField = TextEditingController();
}
