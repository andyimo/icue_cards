/* The root authentication widget 
   Displays either the 'Sign In' or 'Register' screens
   Author: Andy Tran
*/
import 'package:flutter/material.dart';
import 'register.dart';
import 'sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  // This function is going to be called by either Register or Sign In
  // It sets the boolean showSignIn to true if it's currently false and v.v.
  // This is why we need to pass this function into Register() and SignIn()
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
