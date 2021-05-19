import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

Future<bool> registerHandler(
    String? email, String? password, BuildContext context) async {
  if (email == null) {
    return false;
  }
  if (password == null) {
    return false;
  }
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Provided password is too weak!')));
      return false;
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Email is already used!')));
      return false;
    }
  } catch (e) {
    print(e);
  }
  return true;
}
