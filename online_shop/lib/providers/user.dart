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
      //_id = responseData['id'];
      _name = responseData['name'];
      _surname = responseData['surname'];
      _email = responseData['email'];
      // _isAdmin = responseData['isAdmin'];
      // _token = responseData['token'];
      // Cartt aux = responseData['cart'];
      print("cecszzd");
      // _cartItems = aux.cartProducts;
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

  Future<void> rating(double rating, String idProd, String idUser) async {
    final url = Uri.parse('http://localhost:8080/api/review');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: json.encode({
          'addRating': rating,
          'productId': idProd,
          'userId': idUser,
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

  Future<void> favorite(String idProd, String idUser) async {
    final url = Uri.parse('http://localhost:8080/api/favorite');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: json.encode({
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
