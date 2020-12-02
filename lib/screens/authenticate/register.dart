/* Register into ICUE CARDS  
   Author: Andy Tran
*/

import 'package:flutter/material.dart';
import 'package:icue_cards/services/auth.dart';
import 'package:icue_cards/shared/constants.dart';
import 'package:icue_cards/shared/loading.dart';

class Register extends StatefulWidget {
  // This Register widget accepts a toggleView function
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text('Sign up to ICUE CARDS'),
              // Sign in icon
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Sign In'),
                  onPressed: () => widget.toggleView(),
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                // Associate the global _formKey to this form
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    // Enter email field
                    SizedBox(height: 20.0),
                    TextFormField(
                      // decorations are cool
                      // they appear on the field line but disappear when you start typing
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (val) => val.isEmpty ? 'Enter an email' : null,
                      // val represents whatever is in the form field
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    // Enter Password field
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                      // turns text into dots
                      obscureText: true,
                      // Adding ! makes Dart treat val as a non-nullable
                      validator: (val) => val.length < 6
                          ? 'Enter a password 6+ chars long'
                          : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    // Sign in button
                    SizedBox(height: 20.0),
                    RaisedButton(
                        color: Colors.pink[400],
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          // Get the current state of the form and get the values
                          // inside the form fields so we can validate them
                          if(_formKey.currentState.validate()){
                            setState(() => loading = true);
                            dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                            if(result == null) {
                              setState(() {
                                loading = false;
                                error = 'Please supply a valid email';
                              });
                            }
                          }
                        }),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
