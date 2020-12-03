import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:icue_cards/tools/authentication_tools/authentication_service.dart';
import 'package:icue_cards/views/login_register_pages/home_page.dart';
import 'package:icue_cards/views/login_register_pages/login_page.dart';
import 'package:provider/provider.dart';
import 'package:icue_cards/views/card_view.dart';
import 'package:icue_cards/views/create_card.dart';
import 'package:get/get.dart';
import 'package:icue_cards/views/dir_root.dart';
import 'package:icue_cards/views/game_home_page.dart';
import 'package:icue_cards/views/dir_folder.dart';
import './views/BottomNavigationWidget.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
        ),
      ],
      child: AuthenticationWrapper(),
      /*
      child: MaterialApp(
        title: 'Quick and Dirty Login Page',
        home: AuthenticationWrapper(),
      ),
      */
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    if (firebaseUser != null) {
      return HomePage();
    }
    return LoginPage();
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GetMaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => MyApp(),
      '/home': (context) => HomePage(),
      '/newCard': (context) => NewCard(),
      '/cardView': (context) => CardView(),
      '/mainDirectory': (context) => MainDirectory(),
      '/decks': (context) => directoryDeck(),
      '/games': (context) => MyHomePage(),
      '/kahoot': (context) => BottomNavigationWidget(),
    },
  ));
}

/*
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:icue_cards/tools/authentication_tools/authentication_service.dart';
import 'package:icue_cards/views/login_register_pages/home_page.dart';
import 'package:icue_cards/views/login_register_pages/login_page.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
        ),
      ],
      child: MaterialApp(
        title: 'Quick and Dirty Login Page',
        home: AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    if (firebaseUser != null) {
      return HomePage();
    }
    return LoginPage();
  }
}
*/
