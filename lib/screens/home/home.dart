/* The home screen
   [List the things it needs to do here]
   Author: Andy Tran
*/
import 'package:flutter/material.dart';
import 'package:nice_button/NiceButton.dart';
import '../../services/auth.dart';
import 'package:icue_cards/services/database.dart';
import 'package:provider/provider.dart';
//import 'package:icue_cards/main.dart';
import 'package:icue_cards/models/student.dart';

class Home extends StatelessWidget {
  // You need this to access signOut()
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Student>>.value(
      value: DatabaseService().userStream,
      child: Scaffold(
          backgroundColor: Colors.brown[50],
          appBar: AppBar(
            title: Text('ICUE CARDS'),
            backgroundColor: Colors.brown[400],
            elevation: 0.0,
            actions: <Widget>[
              // logout icon
              FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text('logout'),
                onPressed: () async {
                  await _auth.signOut();
                },
              )
            ],
          ),
          body: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: NiceButton(
                    width: 180,
                    elevation: 8.0,
                    radius: 52.0,
                    text: "Cards",
                    background: Colors.brown,
                    onPressed: () {
                      Navigator.pushNamed(context, '/mainDirectory');
                    },
                  ),
                ),
                NiceButton(
                  width: 180,
                  elevation: 8.0,
                  radius: 52.0,
                  text: "Game",
                  background: Colors.brown,
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => Kahoot()),
                    // );
                    Navigator.pushNamed(context, '/kahoot');
                  },
                ),
              ],
            ),
          )),
    );
  }
}
