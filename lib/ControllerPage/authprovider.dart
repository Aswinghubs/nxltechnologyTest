import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLoading = false;
  String? errorMessage;

 Future<bool> login(String email, String password) async {
  try {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return true; 
  } on FirebaseAuthException catch (e) {
    errorMessage = e.message;
    return false; 
  } finally {
    isLoading = false;
    notifyListeners();
  }
}


  Future<bool> register(String email, String password) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return true;
    } on FirebaseAuthException catch (e) {
      errorMessage = e.message;
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
