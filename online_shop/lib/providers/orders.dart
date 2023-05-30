import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './product.dart';
import './cart.dart';

class Order {
  final String userId;
  final Cart cart;
  final double amount;
  final String status;

  Order({
    required this.userId,
    required this.cart,
    required this.amount,
    required this.status,
  });
}

class Orders with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url = Uri.parse('http://localhost:8080/api/orders/status');

    final response = await http.get(url);

    final List<Order> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;

    Map<String, CartProduct> cartItems = {};
    Map<String, dynamic> aux = extractedData['cart']['cartProducts'];
    for (var i = 0; i < aux.length; i++) {
      cartItems[aux.keys.elementAt(i)] = CartProduct(
        id: aux.values.elementAt(i)['productId'],
        title: aux.values.elementAt(i)['title'],
        quantity: aux.values.elementAt(i)['quantity'],
        price: aux.values.elementAt(i)['price'],
      );
    }

    for (var i = 0; i < extractedData.length; i++) {
      loadedOrders.add(Order(
          userId: extractedData[i]['userId'],
          amount: extractedData[i]['amount'],
          status: extractedData[i]['status'],
          cart: Cart(cartItems)));
    }

    _orders = loadedOrders.reversed.toList();

    notifyListeners();
  }

  Future<void> addOrder(List<CartProduct> cartproducts, String userId) async {
    final url = Uri.parse('http://localhost:8080/api/cart/placeOrder');

    final response = await http.post(
      url,
      body: json.encode({
        'userId': userId,
      }),
    );

    _orders.insert(
      0,
      Order(
        userId: userId,
        amount: cartproducts.fold(0, (sum, item) => sum + item.price),
        cart: Cart({for (var e in cartproducts) e.id: e}),
        status: 'PENDING',
      ),
    );

    notifyListeners();
  }
}
