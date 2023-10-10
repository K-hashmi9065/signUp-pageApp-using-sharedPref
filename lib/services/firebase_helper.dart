import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseHelper {
  const FirebaseHelper._();
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static Future<bool> saveUser({
    required BuildContext context,
    required String email,
    required String passWord,
    required String name,
  }) async {
    try {
      final UserCredential credential = await _auth
          .createUserWithEmailAndPassword(email: email, password: passWord);

      if (credential.user != null) {
        return true;
      }

      return false;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
      return false;
    }
  }
}
