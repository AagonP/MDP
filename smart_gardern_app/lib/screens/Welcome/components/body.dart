import 'package:flutter/material.dart';
import 'package:smart_gardern_app/constant.dart';
import 'package:smart_gardern_app/components/rounded_button.dart';
import 'package:smart_gardern_app/screens/Login/login_screen.dart';
import 'background.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context)
        .size; // provides size of the current screen using
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/images/logo.png",
            width: size.width * 0.3,
            height: size.height * 0.2,
          ),
          Padding(
            padding: EdgeInsets.all(size.height * 0.2),
          ),
          RoundedButton(
            text: "Login",
            press: () {
              // TODO: maybe refactor thhis into nagivateToLoginScreen()
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LoginScreen();
              }));
            },
          ),
          RoundedButton(
            text: "Create an account",
            press: () {}, //func to nagivate to Create a new account screen
            color: Colors.white,
            textColor: kPrimaryColor,
          ),
        ],
      ),
    );
  }
}
