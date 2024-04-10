import 'dart:convert';

import 'package:app_10_04_grocery/Model1/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ViewModel extends ChangeNotifier {
  List<Model> ProductList = [];

  List<Model> cartList = [];

  Future<List<Model>> fetchDetails() async {
    try {
      String jsonString =
          await rootBundle.loadString('lib/assets/grocery.json');

      List<dynamic> jsonData = jsonDecode(jsonString);

      ProductList = jsonData.map((item) => Model.fromJson(item)).toList();
      return ProductList;
    } catch (e) {
      throw Exception('Failed to Load Screen');
    }
  }

  void addItemToCart(Model cartAction) {
    if (cartList.contains(cartAction)) {
      cartList.remove(cartAction);
      notifyListeners();
    } else {
      cartList.add(cartAction);
      notifyListeners();
    }
    print(cartList);
    notifyListeners();
  }
}
