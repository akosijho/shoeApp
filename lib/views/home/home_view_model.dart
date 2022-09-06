import 'package:flutter/material.dart';
import 'package:flutter_shoe_app/core/services/api/api_service.dart';
import 'package:flutter_shoe_app/core/services/navigation/navigation_service.dart';
import 'package:flutter_shoe_app/models/shoe_object.dart';
import 'package:flutter_shoe_app/models/user_object.dart';
import 'package:flutter_shoe_app/utils/palette_utils.dart';
import 'package:flutter_shoe_app/views/application/application_view_model.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../app/app.locator.dart';

class HomeViewModel extends ChangeNotifier {
  List<String> categories = [
    "All",
  ];

  User? user;

  final ApplicationViewModel applicationViewModel =
      locator<ApplicationViewModel>();
  final ApiService apiService = locator<ApiService>();
  final NavigationService navigationService = locator<NavigationService>();

  //initialize for color storing
  List<PaletteColor> colors = [];

  //values for each shoe card
  List<Shoe> items = [];
  List<Shoe> itemsByCategory = [];
  String selectedCategory = "All";

  //bottom navbar switching
  bool isHome = false;
  bool isWishlist = false;
  bool isCart = false;
  bool isProfile = false;

  Future<void> getShoes() async {
    if (items != null) {
      items.clear();
      categories.clear();
      categories.add('All');
    }
    final shoes = await apiService.getShoes();
    final shoeCategories = await apiService.getShoesCategory();
    items.addAll(shoes);
    for (var s in shoeCategories) {
      categories.add(s.toString().substring(15, s.toString().length - 1));
    }
  }

  //start shoe horizontal widget//
  bool itemsLoaded = false;

  Future<void> getShoesByCategory(String category) async {
    itemsLoaded = true;
    itemsByCategory.clear();
    final shoes = await apiService.getShoesByCategory(category);
    itemsByCategory.addAll(shoes);
    await getColors(itemsByCategory);
    itemsLoaded = false;
    notifyListeners();
  }

  void onCategorySelected(String category) {
    selectedCategory = category;
    notifyListeners();
  }

//end shoe horizontal widget//

  bool isBusy = false;

  Future<void> initialize() async {
    isBusy = true;
    notifyListeners();
    await getShoes();
    getShoesByCategory(selectedCategory);
    stackIndex = 0;
    isHomeTrue();
    applicationViewModel.getMyCart();
    await getColors(items);
    isBusy = false;
    notifyListeners();
  }

  Future<void> initializeCart() async {
    applicationViewModel.getMyCart();
    notifyListeners();
  }

  Future<void> getColors(List<Shoe> item) async {
    for (Shoe s in item) {
      s.paletteColor = await PaletteUtils.getColorFromImage(s.images![0]);
    }
  }

  void isHomeTrue() {
    isHome = true;
    isWishlist = false;
    isCart = false;
    isProfile = false;
    notifyListeners();
  }

  void isWishlistTrue() {
    isHome = false;
    isWishlist = true;
    isCart = false;
    isProfile = false;
    notifyListeners();
  }

  void isCartTrue() {
    isHome = false;
    isWishlist = false;
    isCart = true;
    isProfile = false;
    notifyListeners();
  }

  void isProfileTrue() {
    isHome = false;
    isWishlist = false;
    isCart = false;
    isProfile = true;
    notifyListeners();
  }

  //IndexedStack
  int stackIndex = 0; //page index

  void changeIndex(int index) {
    stackIndex = index;
    if (stackIndex == 0) {
      isHomeTrue();
    } else if (stackIndex == 1) {
      isCartTrue();
    } else if (stackIndex == 2) {
      isWishlistTrue();
    } else if (stackIndex == 3) {
      isProfileTrue();
    }
    notifyListeners();
  }
}
