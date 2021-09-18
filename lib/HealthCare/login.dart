import 'package:flutter/material.dart';
import 'login2.dart';

class HospitalLogin extends StatefulWidget {
  @override
  _HospitalLoginState createState() => _HospitalLoginState();
}

TextEditingController email;
TextEditingController pass;

class _HospitalLoginState extends State<HospitalLogin> {
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
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HospitalLogin2()));
              },
              child: Text("login"),
            )
          ],
        ),
      ),
    );
  }
}
