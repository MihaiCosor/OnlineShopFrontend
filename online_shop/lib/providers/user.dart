import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
import 'product.dart';

class User with ChangeNotifier {
  String _name = '';
  String _surname = '';
  String _email = '';

  bool _isAdmin = false;
  bool _isLogged = true;

  String _token = '';
  DateTime _expiryDate = DateTime.now();

  List<Product> _favoriteItems = [];
  //TODO: list de recenzii

  String get name {
    return _name;
  }

  String get surname {
    return _surname;
  }

  String get email {
    return _email;
  }

  List<Product> get favoriteItems {
    return [..._favoriteItems];
  }

  bool get isAuth {
    //return _expiryDate.isAfter(DateTime.now());
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
    _token = '';
    _expiryDate = DateTime.now();
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

      _name = responseData['name'];
      _surname = responseData['surname'];
      _email = responseData['email'];
      _isAdmin = responseData['isAdmin'];
      _token = responseData['token'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseData['expiresIn']),
        ),
      );

      if (_expiryDate.isAfter(DateTime.now())) {
        print("LOGARE CU SUCCES");
      }

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

      _name = responseData['name'];
      _surname = responseData['surname'];
      _email = responseData['email'];
      _isAdmin = responseData['isAdmin'];
      _token = responseData['token'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseData['expiresIn']),
        ),
      );

      if (_expiryDate.isAfter(DateTime.now())) {
        print("INREGISTRE CU SUCCES");
      }

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
