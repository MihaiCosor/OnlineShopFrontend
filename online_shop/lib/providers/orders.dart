import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './product.dart';
import './cart.dart';

class Order {
  final String id;
  final double amount;
  final List<CartProduct> products;
  final DateTime dateTime;

  Order({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<Order> _orders = [
    Order(
      id: "o1",
      amount: 69,
      products: [
        Product(
          id: 'p1',
          title: 'Red Shirt',
          description: 'A red shirt - it is pretty red!',
          price: 29.99,
          imageUrl:
              'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
          rating: 3.7,
          numberOfReviews: 888,
        ),
        Product(
          id: 'p2',
          title: 'Trousers',
          description: 'A nice pair of trousers.',
          price: 59.99,
          imageUrl:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
          rating: 3.2,
          numberOfReviews: 657,
        ),
        Product(
          id: 'p3',
          title: 'Yellow Scarf',
          description: 'Warm and cozy - exactly what you need for the winter.',
          price: 19.99,
          imageUrl:
              'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
          rating: 5.0,
          numberOfReviews: 7,
        ),
      ]
          .map((item) => CartProduct(
              id: item.id, title: item.title, quantity: 2, price: item.price))
          .toList(),
      dateTime: DateTime.now().add(const Duration(days: -1)),
    ),
    Order(
      id: "o2",
      amount: 1239,
      products: [
        Product(
          id: 'p1',
          title: 'Red Shirt',
          description: 'A red shirt - it is pretty red!',
          price: 29.99,
          imageUrl:
              'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
          rating: 3.7,
          numberOfReviews: 888,
        ),
        Product(
          id: 'p2',
          title: 'Trousers',
          description: 'A nice pair of trousers.',
          price: 59.99,
          imageUrl:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
          rating: 3.2,
          numberOfReviews: 657,
        ),
        Product(
          id: 'p3',
          title: 'Yellow Scarf',
          description: 'Warm and cozy - exactly what you need for the winter.',
          price: 19.99,
          imageUrl:
              'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
          rating: 5.0,
          numberOfReviews: 7,
        ),
      ]
          .map((item) => CartProduct(
              id: item.id, title: item.title, quantity: 2, price: item.price))
          .toList(),
      dateTime: DateTime.now(),
    )
  ];

  List<Order> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    notifyListeners();
    return;

    // final url = Uri.parse('http://localhost:8080/orders/' + userId);

    // final response = await http.get(url);

    // final List<Order> loadedOrders = [];
    // final extractedData = json.decode(response.body) as Map<String, dynamic>;

    // // if (extractedData == null) {
    // //   return;
    // // }

    // extractedData.forEach((orderId, odrderData) {
    //   loadedOrders.add(Order(
    //     id: orderId,
    //     amount: odrderData['amount'],
    //     dateTime: DateTime.parse(odrderData['dateTime']),
    //     products: (odrderData['products'] as List<dynamic>)
    //         .map((item) => CartProduct(
    //             id: item['id'],
    //             title: item['title'],
    //             quantity: item['quantity'],
    //             price: item['price']))
    //         .toList(),
    //   ));
    // });

    // _orders = loadedOrders.reversed.toList();

    // notifyListeners();
  }

  Future<void> addOrder(List<CartProduct> cartProducts, double total) async {
    _orders.insert(
      0,
      Order(
        id: 'random',
        amount: total,
        products: cartProducts,
        dateTime: DateTime.now(),
      ),
    );

    notifyListeners();
    return;

    final url = Uri.parse('http://localhost:8080/orders');
    final timestamp = DateTime.now();

    final response = await http.post(
      url,
      body: json.encode({
        'amount': total,
        'dateTime': timestamp.toIso8601String(),
        'products': cartProducts
            .map((cp) => {
                  'id': cp.id,
                  'title': cp.title,
                  'quantity': cp.quantity,
                  'price': cp.price,
                })
            .toList(),
      }),
    );

    _orders.insert(
      0,
      Order(
        id: json.decode(response.body)['name'],
        amount: total,
        products: cartProducts,
        dateTime: timestamp,
      ),
    );

    notifyListeners();
  }
}
