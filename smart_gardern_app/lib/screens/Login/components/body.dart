import 'package:flutter/material.dart';
import 'package:smart_gardern_app/components/rounded_button.dart';
import 'package:smart_gardern_app/screens/Home/home_screen.dart';
import 'package:smart_gardern_app/screens/Login/components/already_have_an_account_check.dart';
import 'package:smart_gardern_app/screens/Login/components/background.dart';
import 'package:smart_gardern_app/screens/Login/components/rounded_input_field.dart';
import 'package:smart_gardern_app/screens/Login/components/rounded_password_field.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
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
          onChanged: (value) {},
        ),
        RoundedPasswordField(
          onChanged: (value) {},
        ),
        RoundedButton(
          text: "Login",
          textColor: Colors.white,
          press: () {
            // On login success
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return HomeScreen();
            }));
          },
        ),
        SizedBox(height: size.height * 0.03),
        AlreadyHaveAnAccountCheck()
      ],
    ));
  }
}
