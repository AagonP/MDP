import 'package:firebase_auth/firebase_auth.dart';

Future<bool> registerHandler(String? email, String? password) async {
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
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
  return true;
}
