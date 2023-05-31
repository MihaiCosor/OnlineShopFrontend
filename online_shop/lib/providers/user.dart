import 'dart:collection';
import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
import './product.dart';
import './cart.dart';

class Cartt {
  HashMap<String, CartProduct> cartProducts = HashMap<String, CartProduct>();
}

class User with ChangeNotifier {
  final Storage _localStorage = window.localStorage;

  String _id = 'aaa';
  String _name = '';
  String _surname = '';
  String _email = '';

  bool _isAdmin = false;
  bool _isLogged = false;

  String? _token = '';

  String get id {
    return _id;
  }

  Map<String, CartProduct> _cartItems = {};
  List<String> _favoriteItems = [];

  String get name {
    return _name;
  }

  String get surname {
    return _surname;
  }

  String get email {
    return _email;
  }

  Map<String, CartProduct> get cartItems {
    return {..._cartItems};
  }

  List<String> get favoriteItems {
    return [..._favoriteItems];
  }

  bool get isAuth {
    // if (_token == null) {
    //   return false;
    // } else {
    //   return JwtDecoder.isExpired(_token!);
    // }
    return _isLogged;
  }

  bool get isAdmin {
    return _isAdmin;
  }

  logout() {
    _name = '';
    _surname = '';
    _email = '';
    _isAdmin = false;
    _isLogged = false;
    _token = null;
    _favoriteItems = [];

    _isLogged = false;
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    final url = Uri.parse('http://localhost:8080/api/auth/login');
    print("tesssssssssssssssssssssssssst");
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      print("aici");
      final responseData = json.decode(response.body);
      print("dupa");
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      print("final");

      print(responseData);
      print(responseData['id']);
      print("aaasdasd");
      _id = responseData['id'];
      _name = responseData['name'];
      _surname = responseData['surname'];
      _email = responseData['email'];
      String userRole = responseData['userRole'];
      print(userRole);
      if (userRole == "ADMIN") {
        print("admin");
        _isAdmin = true;
        print("gata");
      } else {
        _isAdmin = false;
      }
      for (var i = 0; i < responseData['favoriteProducts'].length; i++) {
        _favoriteItems.add(responseData['favoriteProducts'][i]);
      }
      //_favoriteItems = responseData['favoriteProducts'];
      print(_favoriteItems);
      // _token = responseData['token'];
      print(responseData['cart']['cartProducts'].runtimeType);
      // Cartt aux = responseData['cart'];
      print("cecszzd");
      Map<String, dynamic> aux = responseData['cart']['cartProducts'];
      for (var i = 0; i < aux.length; i++) {
        _cartItems[aux.keys.elementAt(i)] = CartProduct(
          id: aux.values.elementAt(i)['productId'],
          title: aux.values.elementAt(i)['title'],
          quantity: aux.values.elementAt(i)['quantity'],
          price: aux.values.elementAt(i)['price'],
        );
      }
      //_cartItems = responseData['cart']['cartProducts'];
      _isLogged = true;
      print(_isLogged);
      print(_name);

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> register(
      String name, String surname, String email, String password) async {
    final url = Uri.parse('http://localhost:8080/api/auth/register');

    print("o luam de la capat");

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: json.encode({
          'name': name,
          'surname': surname,
          'email': email,
          'password': password,
        }),
      );

      final responseData = json.decode(response.body);

      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }

      print(responseData);
      _id = responseData['id'];
      _name = responseData['name'];
      _surname = responseData['surname'];
      _email = responseData['email'];
      //_isAdmin = responseData['isAdmin'];
      // _token = responseData['token'];
      print(_name);
      // Cartt aux = responseData['cart'];
      print("cecszzd");
      //  _cartItems = aux.cartProducts;
      _isLogged = true;
      print(_isLogged);
      print(_name);

      _isLogged = true;

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> rating(int rating, String idProd, String idUser) async {
    final url = Uri.parse('http://localhost:8080/api/review');

    try {
      print(rating);
      print(idProd);
      print(idUser);
      final response = await http.post(
        url,
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: json.encode({
          'userId': idUser,
          'productId': idProd,
          'addRating': rating,
        }),
      );

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> favorite(String idProd, String idUser) async {
    final url = Uri.parse('http://localhost:8080/users/favorites/add');
    print("teeeest");

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: json.encode({
          'userId': idUser,
          'productId': idProd,
        }),
      );

      _favoriteItems.add(idProd);

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> unfavorite(String idProd, String idUser) async {
    final url = Uri.parse('http://localhost:8080/users/favorites/remove');
    print("teeeest");

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: json.encode({
          'userId': idUser,
          'productId': idProd,
        }),
      );

      _favoriteItems.add(idProd);

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
