import 'package:flutter/material.dart';
import 'package:smart_gardern_app/constant.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function press;
  const AlreadyHaveAnAccountCheck({
    Key key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {},
          child: Text(
            login ? "Don't have an Account ? " : "Already have an Account ?",
            style: TextStyle(color: kPrimaryColor),
          ),
        ),
        GestureDetector(
          child: Text(
            login ? 'Sign Up' : "Sign In",
            style: TextStyle(color: kPrimaryColor),
          ),
        )
      ],
    );
  }
}
