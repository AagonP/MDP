import 'package:flutter/material.dart';

import '../../../../constant.dart';
import '../../Login/login_screen.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function? press;
  const AlreadyHaveAnAccountCheck({
    Key? key,
    this.login = false,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return LoginScreen();
            }));
          },
          child: Text(
            login ? "Don't have an Account ? " : "Already have an Account ?",
            style: TextStyle(color: kPrimaryColor),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return LoginScreen();
            }));
          },
          child: Text(
            login ? 'Sign Up' : "Sign In",
            style: TextStyle(color: kPrimaryColor),
          ),
        )
      ],
    );
  }
}
