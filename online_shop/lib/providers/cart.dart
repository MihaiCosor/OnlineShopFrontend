import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/http_exception.dart';
import 'package:http/http.dart' as http;

import './user.dart';

class CartProduct {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartProduct({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartProduct> _items = {};

  Map<String, CartProduct> get items {
    return {..._items};
  }

  set items(Map<String, CartProduct> items) {
    _items = items;
  }

  int get itemCount {
    return _items.values
        .map((value) => value.quantity)
        .fold(0, (sum, val) => sum + val);
  }

  int get singleItemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });

    return total;
  }

  Future<void> addItem(String productId, double price, String title, String userId) async {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingCartItem) => CartProduct(
                id: existingCartItem.id,
                title: existingCartItem.title,
                quantity: existingCartItem.quantity + 1,
                price: existingCartItem.price,
              ));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartProduct(
                id: DateTime.now().toString(),
                title: title,
                quantity: 1,
                price: price,
              ));
    }

    //TODO: send request
    // final url = Uri.parse('http://localhost:8080/api/cart/add');
    // print("teeeest");
    // try {
    //   final response = await http.post(
    //     url,
    //     headers: <String, String>{
    //       "Content-Type": "application/json; charset=UTF-8"
    //     },
    //     body: json.encode({
    //       'userId': userId,
    //       'productId': productId,
    //       'quantity': 1,
    //     }),
    //   );

    //   print("send");
    //   final responseData = json.decode(response.body);
    //   print(responseData.toString() + "response");
    //   if (responseData['error'] != null) {
    //     throw HttpException(responseData['error']['message']);
    //   }
    // } catch (error) {
    //   rethrow;
    // }

    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }

    if (_items[productId]!.quantity > 1) {
      _items.update(
        productId,
        (existingCartItem) => CartProduct(
            id: existingCartItem.id,
            title: existingCartItem.title,
            quantity: existingCartItem.quantity - 1,
            price: existingCartItem.price),
      );
    } else {
      _items.remove(productId);
    }

    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
