import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  Future<void> login(String email, String password) async {
    // await FirebaseAuth.instance.signInWithEmailAndPassword(...)
    
    // Simulasi loading
    await Future.delayed(const Duration(seconds: 1)); 
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}