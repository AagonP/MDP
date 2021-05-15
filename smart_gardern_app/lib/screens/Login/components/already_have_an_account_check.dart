import 'package:flutter/material.dart';
import 'package:smart_gardern_app/constant.dart';
import 'package:smart_gardern_app/screens/Register/register_screen.dart';

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
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return RegisterScreen();
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
              return RegisterScreen();
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
