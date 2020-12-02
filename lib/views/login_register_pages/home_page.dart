import 'package:flutter/material.dart';
import 'package:icue_cards/tools/authentication_tools/authentication_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("HOME"),
            RaisedButton(
              onPressed: () {
                context.read<AuthenticationService>().logout();
              },
              child: Text("SIGN OUT"),
            ),
          ],
        ),
      ),
    );
  }
}
