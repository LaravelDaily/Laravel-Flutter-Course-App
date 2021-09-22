import 'package:flutter/material.dart';
import 'package:my_first_app/services/api.dart';

class AuthProvider extends ChangeNotifier {

  bool isAuthenticated = false;

  ApiService apiService = new ApiService();

  Future<String> register(String name, String email, String password,
      String passwordConfirm, String deviceName) async {

    String token = await apiService.register(name, email, password, passwordConfirm, deviceName);
    notifyListeners();

    isAuthenticated = true;

    return token;
  }

  Future<String> login(String email, String password, String deviceName) async {

    String token = await apiService.login(email, password, deviceName);
    notifyListeners();

    isAuthenticated = true;

    return token;
  }
}