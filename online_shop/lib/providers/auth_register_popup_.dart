import 'package:flutter/material.dart';

class AuthRegister with ChangeNotifier {
  bool _isLoginPopUp = true;

  bool get isLoginPopUp {
    return _isLoginPopUp;
  }

  void setIsLoginPopUp(newValue) {
    _isLoginPopUp = newValue;
    notifyListeners();
  }
}
