/* Sign into ICUE CARDS  
   Author: Andy Tran
*/

import 'package:flutter/material.dart';
import 'package:icue_cards/shared/constants.dart';
import 'package:icue_cards/services/auth.dart';
import 'package:icue_cards/shared/loading.dart';
import 'package:nice_button/NiceButton.dart';

class SignIn extends StatefulWidget {
  // This SignIn() widget accepts a toggleView function
  // Needed later so we can switch to the Register page when the user clicks
  // the Register icon
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Color(0xffa5eaee),
            /*
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text('Sign in to ICUE CARDS'),
              actions: <Widget>[
                FlatButton.icon(
                    icon: Icon(Icons.person),
                    label: Text('Register'),
                    onPressed: () {
                      widget.toggleView();
                    }),
              ],
            ),
            */
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 100.0),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Image.asset('assets/brain_logo.png'),
                    ),
                    // Enter email field
                    TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
                        // val represents whatever is in the form field
                        validator: (val) =>
                            val.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        }),
                    // Enter Password field
                    SizedBox(height: 20.0),
                    TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Password'),
                        // turns text into dots
                        obscureText: true,
                        validator: (val) => val.length < 6
                            ? 'Enter a password 6+ chars long'
                            : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        }),
                    // Sign in button
                    SizedBox(height: 20.0),
                    NiceButton(
                        width: 300,
                        elevation: 8.0,
                        radius: 52.0,
                        text: "Login",
                        background: Color(0xfff57878),
                        onPressed: () async {
                          // Get the current state of the form and get the values
                          // inside the form fields so we can validate them
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            dynamic result = await _auth
                                .signInWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error =
                                    'Could not sign in with those credentials';
                              });
                            }
                          }
                        }),
                    /*
                    RaisedButton(
                        color: Colors.pink[400],
                        child: Text(
                          'Sign in',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          // Get the current state of the form and get the values
                          // inside the form fields so we can validate them
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            dynamic result = await _auth
                                .signInWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error =
                                    'Could not sign in with those credentials';
                              });
                            }
                          }
                        }),*/
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                    SizedBox(height: 80.0),
                    TextButton(
                        child: Text(
                          'New here? Create an account',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Color(0xff3e85ee),
                          ),
                        ),
                        onPressed: () {
                          widget.toggleView();
                        }),
                  ],
                ),
              ),
            ),
          );
  }
}
