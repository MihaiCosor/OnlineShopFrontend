import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
import './product.dart';
import './cart.dart';

class User with ChangeNotifier {
  final Storage _localStorage = window.localStorage;

  String _id = 'aaa';
  String _name = '';
  String _surname = '';
  String _email = '';

  bool _isAdmin = false;
  bool _isLogged = true;

  String? _token = '';

  String get id {
    return _id;
  }

  Map<String, CartProduct> _cartItems = {};
  List<Product> _favoriteItems = [];

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

  List<Product> get favoriteItems {
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
    final url = Uri.parse('http://localhost:8080/login');

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

      final responseData = json.decode(response.body);

      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }

      _id = responseData['id'];
      _name = responseData['name'];
      _surname = responseData['surname'];
      _email = responseData['email'];
      _isAdmin = responseData['isAdmin'];
      _token = responseData['token'];
      _cartItems = responseData['cart'];

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> register(
      String name, String surname, String email, String password) async {
    final url = Uri.parse('http://localhost:8080/register');

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

      _id = responseData['id'];
      _name = responseData['name'];
      _surname = responseData['surname'];
      _email = responseData['email'];
      _isAdmin = responseData['isAdmin'];
      _token = responseData['token'];
      _cartItems = responseData['cart'];

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> rating(double rating, String idProd, String idUser) async {
    final url = Uri.parse('http://localhost:8080/api/review');
    print('In rating');
    print(rating);
    print(idProd);
    print(idUser);

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: json.encode({
          'rating': rating,
          'idProd': idProd,
          'idUser': idUser,
        }),
      );

      final responseData = json.decode(response.body);

      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
