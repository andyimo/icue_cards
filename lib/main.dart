import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icue_cards/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'services/auth.dart';
import 'screens/wrapper.dart';
import 'package:icue_cards/views/card_view.dart';
import 'package:icue_cards/views/create_card.dart';
import 'package:icue_cards/views/card_list.dart';
import 'package:get/get.dart';
import 'package:icue_cards/views/dir_root.dart';
import 'package:icue_cards/views/game_home_page.dart';
import 'package:icue_cards/views/dir_folder.dart';
import './views/BottomNavigationWidget.dart';

void main() {
  runApp(GetMaterialApp(
    initialRoute:
        '/home', //in this line, change '/home' to '/' to test the login
    routes: {
      '/': (context) => Login(),
      '/home': (context) => Home(),
      '/lists': (context) => Lists(),
      '/newCard': (context) => NewCard(),
      '/cardView': (context) => CardView(),
      '/mainDirectory': (context) => mainDirectory(),
      '/decks': (context) => directoryDeck(),
      '/games': (context) => MyHomePage(),
      '/kahoot': (context) => BottomNavigationWidget(),
    },
  ));
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This StreamProvider stuff is what will allow our Wrapper() to receive
    // information about whether or not the user is signed in or not from Firebase
    return StreamProvider<FirebaseUser>.value(
      value: AuthService()
          .user, // specifies that we are listening to the user stream
      child: Wrapper(),
      // Run Wrapper() first when the app starts up
      // Wrapper() determines whether or not to display Home() or Authenticate()
    );
  }
}
