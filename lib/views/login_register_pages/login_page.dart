import 'package:flutter/material.dart';
import 'package:icue_cards/tools/authentication_tools/authentication_service.dart';
import 'package:provider/provider.dart';

const myStylishText = InputDecoration(
  hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey),
  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
  filled: true,
  fillColor: Colors.white30,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(30)),
    borderSide: BorderSide.none,
  ),
);

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/plant.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 300),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                child: TextField(
                  controller: emailController,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                  decoration: myStylishText.copyWith(
                    hintText: "Email",
                    suffixIcon: Icon(
                      Icons.email,
                      color: Colors.grey,
                      size: 30,
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                  decoration: myStylishText.copyWith(
                    hintText: "Password",
                    suffixIcon: Icon(
                      Icons.lock,
                      color: Colors.grey,
                      size: 30,
                    ),
                  ),
                ),
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  side: BorderSide.none,
                ),
                onPressed: () {
                  context.read<AuthenticationService>().login(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      );
                },
                child: Text(
                  "Connect",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    /*
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: "EMAIL",
            ),
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: "PASSWORD",
            ),
          ),
          RaisedButton(
            onPressed: () {
              context.read<AuthenticationService>().login(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  );
            },
            child: Text(
              "Se connecter",
              style: TextStyle(
                fontSize: 25.0,
                fontFamily: 'Habel',
              ),
            ),
          ),
        ],
      ),
    ); */
  }
}
