import 'package:firebase_auth/firebase_auth.dart';

Future<bool> loginHandler(final String email, final String password) async {
  if (email == null) {
    print("User email is null!");
    return false;
  }
  if (password == null) {
    print("User password is null!");
    return false;
  }
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
  return true;
}
