import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../components/rounded_button.dart';
import '../../Home/home_screen.dart';
import 'already_have_an_account_check.dart';
import 'background.dart';
import 'rounded_input_field.dart';
import 'rounded_password_field.dart';
import '../register_screen_controller.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String? email;
    String? password;
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
          MyCustomForm(),
          AlreadyHaveAnAccountCheck(),
        ],
      )),
    );
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Add TextFormFields and ElevatedButton here.
          RoundedInputField(
            controller: emailController,
            hintText: 'Your Email',
            icon: Icon(Icons.person, color: Colors.white),
          ),
          RoundedInputField(
            controller: phoneController,
            hintText: 'Your phone',
            icon: Icon(Icons.phone, color: Colors.white),
          ),
          RoundedInputField(
            controller: addressController,
            hintText: 'Your address',
            icon: Icon(Icons.home, color: Colors.white),
          ),
          RoundedPasswordField(
            controller: passwordController,
          ),
          RoundedButton(
            text: "Register",
            textColor: Colors.white,
            press: () async {
              if (_formKey.currentState!.validate()) {
                // If the form is valid, display a snackbar. In the real world,
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Loading')));
              } else {
                return;
              }
              if (await registerHandler(
                  emailController.text, passwordController.text)) {}
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return HomeScreen();
              }));
            },
          ),
        ],
      ),
    );
  }
}
