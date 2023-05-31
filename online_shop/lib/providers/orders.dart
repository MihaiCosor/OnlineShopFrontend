import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './product.dart';
import './cart.dart';

class Order {
  final String userId;
  final String orderId;
  final Cart cart;
  final double amount;
  final String status;

  Order({
    required this.userId,
    required this.orderId,
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

  Future<void> fetchAndSetOrders(String userId, bool isAdmin) async {
    print(userId);
    final url = isAdmin ? Uri.parse('http://localhost:8080/api/order/status/' + userId) : Uri.parse('http://localhost:8080/api/order/user/' + userId);

    final response = await http.get(url);

    final List<Order> loadedOrders = [];
    final extractedData = json.decode(response.body);
    print(extractedData);

    for (var i = 0; i < extractedData.length; i++) {    Map<String, CartProduct> cartItems = {};
      Map<String, dynamic> aux = extractedData[i]['cart']['cartProducts'];
      for (var j = 0; j < aux.length; j++) {
        cartItems[aux.keys.elementAt(j)] = CartProduct(
          id: aux.values.elementAt(j)['productId'],
          title: aux.values.elementAt(j)['title'],
          quantity: aux.values.elementAt(j)['quantity'],
          price: aux.values.elementAt(j)['price'],
        );
      }
      print("cartItems: " + cartItems.toString());

      loadedOrders.add(Order(
          orderId: extractedData[i]['id'],
          userId: extractedData[i]['userId'],
          amount: cartItems.values.toList().fold(0, (sum, item) => sum + item.price),
          status: extractedData[i]['orderStatus'],
          cart: Cart(cartItems)));
    }

    _orders = loadedOrders.reversed.toList();

    notifyListeners();
  }

  Future<void> addOrder(List<CartProduct> cartproducts, String userId) async {
    final url = Uri.parse('http://localhost:8080/api/cart/placeOrder');
    print("userId: " + userId);
    final response = await http.post(
      url,
              headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
      body: json.encode({
        'userId': userId,
      }),
    );

    _orders.insert(
      0,
      Order(
        orderId: response.body,
        userId: userId,
        amount: cartproducts.fold(0, (sum, item) => sum + item.price),
        cart: Cart({for (var e in cartproducts) e.id: e}),
        status: 'PENDING',
      ),
    );

    print("order id: " + response.body);

    notifyListeners();
  }

  Future<void> updateOrder(String orderId, String userId) async {
    final url = Uri.parse('http://localhost:8080/api/order/delivered');
    final response = await http.post(
      url,
      headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
      body: json.encode({
        'userId': userId,
        'orderId': orderId,
      }),
    );

    notifyListeners();
  }
}
