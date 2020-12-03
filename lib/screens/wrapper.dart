/* Listens for auth changes 
   Returns either 'Home' or 'Authenticate' widgets
   Author: Andy Tran
*/
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authenticate/authenticate.dart';
import 'home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Remember that provider is what enables us to listen to streams from Firebase
    // Firebase sends us either a FirebaseUser (if a user is signed into our app)
    // or NULL if they are signed out.
    final user = Provider.of<FirebaseUser>(context);

    // Show the Home screen if the user is logged in
    // Show the Authenticate screens if the user is not logged in.
    // ignore: unnecessary_null_comparison
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
