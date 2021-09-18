import 'package:flutter/material.dart';

class PoliceLogin extends StatefulWidget {
  @override
  _PoliceLoginState createState() => _PoliceLoginState();
}

TextEditingController email;
TextEditingController pass;

class _PoliceLoginState extends State<PoliceLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("login"),
            TextField(
              controller: email,
              decoration: InputDecoration(hintText: "email"),
            ),
            TextField(
              controller: pass,
              decoration: InputDecoration(hintText: "password"),
            ),
            MaterialButton(
              onPressed: () {},
              child: Text("login"),
            )
          ],
        ),
      ),
    );
  }
}
