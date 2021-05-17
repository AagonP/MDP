import 'package:flutter/material.dart';
import '../../../../constant.dart';
import '../../../../components/rounded_button.dart';
import '../../Login/login_screen.dart';
import '../../Register/register_screen.dart';
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
              //maybe refactor this into nagivateToLoginScreen()
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LoginScreen();
              }));
            },
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return RegisterScreen();
              }));
            },
            child: Text(
              "Create an account",
              style: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
