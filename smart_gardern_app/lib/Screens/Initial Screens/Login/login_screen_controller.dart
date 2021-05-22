import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<bool> loginHandler(
    String email, String password, BuildContext context) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Username is not exist!')));
      return false;
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Wrong password!')));

      return false;
    }
  }
  return true;
}
