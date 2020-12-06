/* The home screen
   [List the things it needs to do here]
   Author: Andy Tran
*/
import 'package:flutter/material.dart';
import 'package:icue_cards/views/dir_root.dart';
import 'package:icue_cards/views/game.dart';
import 'package:nice_button/NiceButton.dart';
import '../../services/auth.dart';
import 'package:icue_cards/services/database.dart';
import 'package:provider/provider.dart';
import 'package:icue_cards/models/student.dart';
import 'package:icue_cards/models/root.dart';
import 'package:icue_cards/services/initState.dart';

class Home extends StatelessWidget {
  // You need this to access signOut()
  final AuthService _auth = AuthService();

  Root root = initState();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Student>>.value(
      value: DatabaseService().userStream,
      child: Scaffold(
          backgroundColor: Color(0xff3e85ee),
          appBar: AppBar(
            title: Text('ICUE CARDS'),
            backgroundColor: Color(0xff3e85ee),
            elevation: 0.0,
            actions: <Widget>[
              NiceButton(
                width: 110,
                elevation: 8.0,
                radius: 52.0,
                text: "Sign out",
                background: Colors.red[800],
                onPressed: () async {
                  await _auth.signOut();
                },
              ),
            ],
          ),
          body: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: FlatButton(
                    padding: EdgeInsets.all(0.0),
                    child: Image.asset('assets/study_button.png'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MainDirectory(
                                  root: root,
                                )),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: FlatButton(
                    padding: EdgeInsets.all(0.0),
                    child: Image.asset('assets/game_button.png'),
                    onPressed: () {
                      Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GamePage(root: root,)));
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
