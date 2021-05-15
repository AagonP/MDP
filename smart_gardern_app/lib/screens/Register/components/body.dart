import 'package:flutter/material.dart';
import 'package:smart_gardern_app/components/rounded_button.dart';
import 'package:smart_gardern_app/screens/Home/home_screen.dart';
import 'package:smart_gardern_app/screens/Register/components/already_have_an_account_check.dart';
import 'package:smart_gardern_app/screens/Register/components/background.dart';
import 'package:smart_gardern_app/screens/Register/components/rounded_input_field.dart';
import 'package:smart_gardern_app/screens/Register/components/rounded_password_field.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_gardern_app/screens/Register/register_screen_controller.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String email;
    String password;
    String address;
    String phone;
    return SingleChildScrollView(
      child: Background(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/images/logo.png",
            width: size.width * 0.3,
            height: size.height * 0.2,
          ),
          RoundedInputField(
            hintText: 'Your Email',
            icon: Icon(Icons.person, color: Colors.white),
            onChanged: (value) {
              email = value;
            },
          ),
          RoundedInputField(
            hintText: 'Your phone',
            icon: Icon(Icons.phone, color: Colors.white),
            onChanged: (value) {
              phone = value;
            },
          ),
          RoundedInputField(
            hintText: 'Your address',
            icon: Icon(Icons.home, color: Colors.white),
            onChanged: (value) {
              address = value;
            },
          ),
          RoundedPasswordField(
            onChanged: (value) {
              password = value;
            },
          ),
          RoundedButton(
            text: "Register",
            textColor: Colors.white,
            press: () async {
              // TODO: Create user with firebase auth then uploading user data (phone,address) to firecloud then extract this method
              if (await registerHandler(email, password)) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return HomeScreen();
                }));
              }
            },
          ),
          AlreadyHaveAnAccountCheck(),
        ],
      )),
    );
  }
}
